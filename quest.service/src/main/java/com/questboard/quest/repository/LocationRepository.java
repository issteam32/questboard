package com.questboard.quest.repository;

import com.questboard.quest.entity.Location;
import org.springframework.data.repository.reactive.ReactiveCrudRepository;

public interface LocationRepository extends ReactiveCrudRepository<Location, Integer> {
}
