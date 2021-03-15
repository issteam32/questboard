package com.questboard.user.response;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import reactor.util.annotation.Nullable;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class RespBody<T> {
    protected List<String> required;
    @Nullable
    protected T data;
    protected Long responseTime;
    protected String error;
    protected int errorCount;
    protected Boolean success;

    public static <T> RespBody<T> body(T body) {
        return new RespBody<T>(body);
    }

    public RespBody() {
    }

    public RespBody(T data) {
        this.data = data;
        this.error = "";
        this.errorCount = 0;
        this.success = true;
        this.responseTime = new Date().getTime();
        this.required = new ArrayList<>();
    }

    public RespBody(T data, String[] required) {
        this.data = data;
        this.error = "";
        this.errorCount = 0;
        this.success = true;
        this.responseTime = new Date().getTime();
        this.required = List.of(required);
    }

    public RespBody(String error) {
        this.data = null;
        this.error = error;
        if (error.contains("\n")) {
            String[] errors = error.split("\n");
            this.errorCount = errors.length;
            this.success = false;
            this.responseTime = new Date().getTime();
        }
        this.required = new ArrayList<>();
    }

    public RespBody(T data, String error) {
        this.data = data;
        this.error = error;
        if (error.contains("\n")) {
            String[] errors = error.split("\n");
            this.errorCount = errors.length;
            this.success = false;
            this.responseTime = new Date().getTime();
        }
        this.required = new ArrayList<>();
    }

    public RespBody(T data, String error, String[] required) {
        this.data = data;
        this.error = error;
        this.required = List.of(required);
        if (error.contains("\n")) {
            String[] errors = error.split("\n");
            this.errorCount = errors.length;
            this.success = false;
            this.responseTime = new Date().getTime();
        }
    }

    public RespBody<T> addRequired(String requiredField) {
        this.required.add(requiredField);
        return this;
    }

    public RespBody<T> setRequired(String[] requiredFields) {
        this.required = List.of(requiredFields);
        return this;
    }

    public RespBody<T> setResponseData(T data) {
        this.data = data;
        return this;
    }

    public RespBody<T> setResponseTime(Long time) {
        this.responseTime = time;
        return this;
    }

    public RespBody<T> setError(String err) {
        this.error = err;
        return this;
    }

    public RespBody<T> addError(String err) {
        this.error += "\n" + err;
        return this;
    }

    public RespBody<T> setErrorCount(int count) {
        this.errorCount = count;
        return this;
    }

    public RespBody<T> errorIncrement() {
        this.errorCount += 1;
        return this;
    }

    public RespBody<T> success() {
        this.success = true;
        return this;
    }

    public RespBody<T> failed() {
        this.success = false;
        return this;
    }

    public void end() {
    }
}
