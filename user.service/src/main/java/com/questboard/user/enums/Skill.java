package com.questboard.user.enums;

public enum Skill {
    ACCOUNT_AND_BOOKING("Accounting & Bookkeeping"),
    COMMUNICATION("Communication"),
    COOKING("Cooking"),
    DESIGN("Design"),
    DIGITAL_PRINTING("Digital Printing"),
    ELECTRONIC("Electronic"),
    ENGINEERING("Engineering"),
    GAMING("Gaming"),
    GARDENING("Gardening"),
    HOUSEKEEPING("Housekeeping"),
    INFORMATION_TECHNOLOGY("Information Technology"),
    MACHINERY("Machinery"),
    NEGOTIATION("Negotiation"),
    PHOTOGRAPHY("Photography"),
    REPAIRING("Repairing"),
    ROBOTICS("Robotics"),
    TEACHING("Teaching"),
    SEWING("Sewing"),
    WATERING("Watering"),
    WRITING("Writing"),
    VIDEOGRAPHY("Videography"),
    YOUTUBER("Youtuber");

    public final String label;

    Skill(String label) {
        this.label = label;
    }
}