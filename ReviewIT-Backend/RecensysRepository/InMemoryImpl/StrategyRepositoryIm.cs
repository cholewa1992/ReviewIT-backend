﻿using System.Collections.Generic;
using RecensysRepository.Entities;
using RecensysRepository.Interfaces;

namespace RecensysRepository.InMemoryImpl
{
    public class StrategyRepositoryIm : IStrategyRepository
    {

        private List<StrategyEntity> _strategies = new List<StrategyEntity>()
        {
        };

        public void Dispose()
        {
        }

        public IEnumerable<StrategyEntity> GetAll()
        {
            return _strategies;
        }

        public void Create(StrategyEntity item)
        {
            _strategies.Add(item);
        }

        public StrategyEntity Read(int id)
        {
            return _strategies.Find(dto => dto.Id == id);
        }

        public void Update(StrategyEntity item)
        {
            _strategies.RemoveAll(dto => dto.Id == item.Id);
            _strategies.Add(item);
        }

        public void Delete(int id)
        {
            _strategies.RemoveAll(dto => dto.Id == id);
        }
    }
}