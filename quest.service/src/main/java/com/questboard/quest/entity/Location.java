package com.questboard.quest.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("location")
public class Location {
    @Id
    public Integer id;
    @Column("longitude")
    public String longitude;
    @Column("latitude")
    public String latitude;
    @Column("unit_no")
    public String unitNo;
    @Column("address1")
    public String address1;
    @Column("address2")
    public String address2;
    @Column("postal_code")
    public String postalCode;
    @Column("state")
    public String state;
    @Column("country")
    public String country;
    @Column("quest_id")
    public Integer questId;

    public Location() {
    }

    public Location(Integer id, String longitude, String latitude, String unitNo, String address1, String address2,
                    String postalCode, String state, String country, Integer questId) {
        this.id = id;
        this.longitude = longitude;
        this.latitude = latitude;
        this.unitNo = unitNo;
        this.address1 = address1;
        this.address2 = address2;
        this.postalCode = postalCode;
        this.state = state;
        this.country = country;
        this.questId = questId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getUnitNo() {
        return unitNo;
    }

    public void setUnitNo(String unitNo) {
        this.unitNo = unitNo;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Integer getQuestId() {
        return questId;
    }

    public void setQuestId(Integer questId) {
        this.questId = questId;
    }
}