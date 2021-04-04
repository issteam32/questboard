package com.questboard.quest.util;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.HashMap;

public class ReqBodyUtils {
    public static <T> Object convertValue(HashMap param, Class<T> clz) {
        final ObjectMapper mapper = new ObjectMapper();
        T pojo = mapper.convertValue(param, clz);
        return pojo;
    }

}
