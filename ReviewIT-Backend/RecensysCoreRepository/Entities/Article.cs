﻿using System.Collections;
using System.Collections.Generic;

namespace RecensysCoreRepository.Entities
{
    public class Article
    {
        public int Id { get; set; }
        public int StudyId { get; set; }
        public virtual Study Study { get; set; }

        //public virtual ICollection<TaskEntity> Tasks { get; set; } = new List<TaskEntity>();
        public virtual ICollection<Data> Data { get; set; } = new List<Data>();
    }
}