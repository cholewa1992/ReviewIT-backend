﻿using System;
using RecensysCoreRepository.DTOs;

namespace RecensysCoreRepository.Repositories
{
    public interface IReviewTaskRepository: IDisposable
    {

        ReviewTaskListDTO GetListDto(int stageId, int userId);

    }
}