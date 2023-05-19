package com.example.demo.dao;

import java.util.List;

import com.example.demo.config.entity.Inquiry;

public interface InquiryDao {

    void insertInquiry(Inquiry inquiry);
    
    int updateInquiry(Inquiry inquiry);
    
    List<Inquiry> getAll();
}
