package com.example.blog.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int id;
	private String title;
	private String content;
	private int insId;
	private Timestamp insDt;
	private Timestamp updDt;
	private Timestamp delDt;

	private String username;
	private String profile;
}
