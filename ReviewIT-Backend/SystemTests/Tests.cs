﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http.Internal;
using Microsoft.AspNetCore.TestHost;
using Moq;
using Newtonsoft.Json;
using RecensysCoreBLL;
using RecensysCoreRepository.DTOs;
using RecensysCoreRepository.EFRepository.Repositories;
using RecensysCoreRepository.Repositories;
using RecensysCoreWebAPI;
using RecensysCoreWebAPI.Controllers;
using Xunit;

namespace SystemTests
{

    public class TestFixture : IDisposable
    {

        public TestServer TestServer { get; set; }
        public HttpClient HttpClient { get; set; }
        public string StudyId { get; set; }
        public string StageId { get; set; }
        public int UserId { get; set; }

        public TestFixture()
        {
            TestServer = new TestServer(new WebHostBuilder()
                .UseStartup<Startup>());
            HttpClient = TestServer.CreateClient();
            
        }

        public void Dispose()
        {
            TestServer.Dispose();
            HttpClient.Dispose();
        }
        
    }

    


    public class Tests : IClassFixture<TestFixture>
    {
        private TestFixture _f;

        public Tests(TestFixture fixture)
        {
            _f = fixture;
        }


        [Fact(DisplayName = "Go through a whole study with 100 articles and 2 phases")]
        public async Task TestRunner()
        {
            await Study_Post_Get();
            await Source_Post();
            await AddIsGSDField();
            await AddUser();
            await AddStage();
            await StageFields();
        }

        //[Fact(DisplayName = "Post new study")]
        public async Task Study_Post_Get()
        {
            var dto = new StudyDetailsDTO
            {
                Name = "Test Study"
            };

            // Act
            var response = await _f.HttpClient.PostAsync("api/study", new StringContent(JsonConvert.SerializeObject(dto),Encoding.UTF8,"application/json"));
            response.EnsureSuccessStatusCode();
            _f.StudyId = await response.Content.ReadAsStringAsync();

            var getResponse = await _f.HttpClient.GetStringAsync($"api/study/{_f.StudyId}");
            var resDto = JsonConvert.DeserializeObject<StudyDetailsDTO>(getResponse);

            // Assert
            Assert.Equal("Test Study", resDto.Name);
        }

        //[Fact(DisplayName = "Post bibtex with 100 articles returns 100")]
        public async Task Source_Post()
        {
            //var stream = new Byte("bibtex100.bib", FileMode.Open);
            var bibtex = File.ReadAllBytes("bibtex100.bib");
            var dataContent = new MultipartFormDataContent();
            var fileContent = new ByteArrayContent(bibtex);
            fileContent.Headers.ContentType = MediaTypeHeaderValue.Parse("application/octet-stream");
            dataContent.Add(fileContent, "file", "bibtex100.bib");

            // Act
            var response =
                await _f.HttpClient.PostAsync($"api/study/{_f.StudyId}/config/source", dataContent);
            

            response.EnsureSuccessStatusCode();
            var nrOfArticles = await response.Content.ReadAsStringAsync();
            
            // Assert
            Assert.Equal("100", nrOfArticles);
        }

        public async Task AddIsGSDField()
        {
            var response = await _f.HttpClient.GetStringAsync($"api/study/{_f.StudyId}/field");
            var responseDto = JsonConvert.DeserializeObject<FieldDTO[]>(response).ToList();

            Assert.Equal(13, responseDto.Count);
            var isGsdField = new FieldDTO
            {
                DataType = DataType.Boolean,
                Name = "IsGSD?"
            };
            responseDto.Add(isGsdField);

            var content = new StringContent(JsonConvert.SerializeObject(responseDto), Encoding.UTF8, "application/json");
            var response2 = await _f.HttpClient.PutAsync($"api/study/{_f.StudyId}/field", content);
            response2.EnsureSuccessStatusCode();

            var response3 = await _f.HttpClient.GetStringAsync($"api/study/{_f.StudyId}/field");
            var response3Dto = JsonConvert.DeserializeObject<FieldDTO[]>(response3);

            Assert.Equal(14, response3Dto.Length);
        }

        //[Fact(DisplayName = "Add a user to the study")]
        public async Task AddUser()
        {
            var dto = new List<StudyMemberDTO>
            {
                new StudyMemberDTO
                {
                    Id = 1,
                }
            };
            var content = new StringContent(JsonConvert.SerializeObject(dto), Encoding.UTF8, "application/json");

            var response = await _f.HttpClient.PutAsync($"api/study/{_f.StudyId}/studymember", content);
            response.EnsureSuccessStatusCode();

            var response2 = await _f.HttpClient.GetStringAsync($"api/study/{_f.StudyId}/studymember");

            var resDto = JsonConvert.DeserializeObject<StudyMemberDTO[]>(response2);
            Assert.Equal(1, resDto.Length);
        }

        //[Fact(DisplayName = "Add a stage to the study and verify the name")]
        public async Task AddStage()
        {
            var dto = new StageDetailsDTO
            {
                Name = "Test Stage"
            };
            var content = new StringContent(JsonConvert.SerializeObject(dto), Encoding.UTF8, "application/json");
            var response = await _f.HttpClient.PostAsync($"api/study/{_f.StudyId}/stage", content);
            response.EnsureSuccessStatusCode();
            _f.StageId = await response.Content.ReadAsStringAsync();

            var response2 = await _f.HttpClient.GetStringAsync($"api/stage/{_f.StageId}");

            var response2Dto = JsonConvert.DeserializeObject<StageDetailsDTO>(response2);
            Assert.Equal("Test Stage", response2Dto.Name);
        }

        public async Task StageFields()
        {
            var response = await _f.HttpClient.GetStringAsync($"api/stage/{_f.StageId}/stagefield");
            var responseDto = JsonConvert.DeserializeObject<StageFieldsDTO>(response);

            Assert.Equal(14, responseDto.AvailableFields.Count);

            var titleField = responseDto.AvailableFields.Single(f => f.Name == "Title");
            responseDto.AvailableFields.Remove(titleField);
            responseDto.VisibleFields.Add(titleField);
            var isGsdField = responseDto.AvailableFields.Single(f => f.Name == "IsGSD?");
            responseDto.AvailableFields.Remove(isGsdField);
            responseDto.RequestedFields.Add(isGsdField);

            var content = new StringContent(JsonConvert.SerializeObject(responseDto), Encoding.UTF8, "application/json");
            var response2 = await _f.HttpClient.PutAsync($"api/stage/{_f.StageId}/stagefield", content);
            response2.EnsureSuccessStatusCode();

            var response3 = await _f.HttpClient.GetStringAsync($"api/stage/{_f.StageId}/stagefield");
            var response3Dto = JsonConvert.DeserializeObject<StageFieldsDTO>(response3);

            Assert.Equal(12, response3Dto.AvailableFields.Count);
            Assert.Equal(1, response3Dto.VisibleFields.Count);
            Assert.Equal(1, response3Dto.RequestedFields.Count);
        }

    }
}
