package com.questboard.user.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.questboard.user.entity.ProfessionalLevel;
import com.questboard.user.entity.SkillSetProfile;

@JsonAutoDetect
public class SkillSetProfileAndLevelDto {
    SkillSetProfile skillSetProfile;
    ProfessionalLevel professionalLevel;

    public SkillSetProfileAndLevelDto(SkillSetProfile skillSetProfile, ProfessionalLevel professionalLevel) {
        this.skillSetProfile = skillSetProfile;
        this.professionalLevel = professionalLevel;
    }

    public SkillSetProfileAndLevelDto() {
    }

    public SkillSetProfile getSkillSetProfile() {
        return skillSetProfile;
    }

    public void setSkillSetProfile(SkillSetProfile skillSetProfile) {
        this.skillSetProfile = skillSetProfile;
    }

    public ProfessionalLevel getProfessionalLevel() {
        return professionalLevel;
    }

    public void setProfessionalLevel(ProfessionalLevel professionalLevel) {
        this.professionalLevel = professionalLevel;
    }
}
