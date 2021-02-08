package com.sist.music;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class GenieMusic {
	public void getGenieMusic() {
		try {
			int k=1;
			for(int i=1;i<=4;i++) {
				//Document doc = Jsoup.connect("https://www.genie.co.kr/chart/top200?ditc=D&ymd=20210205&hh=12&rtm=Y&pg="+i).get();
				Document doc = Jsoup.connect("https://www.genie.co.kr/chart/top200?ditc=D&ymd=20210205&hh=12&rtm=Y&pg="+i).get();
				
				
				//title, singer, album, states, idcrement, rank
				Elements title = doc.select("tr.list a.title");
				Elements singer = doc.select("tr.list a.artist");
				Elements album = doc.select("tr.list a.albumtitle");
				Elements poster = doc.select("tr.list a.cover img");
				Elements etc = doc.select("tr.list span.rank");
				for(int j=0;j<title.size();j++) {
					System.out.println("순위: "+k++);
					System.out.println("제목: " + title.get(j).text());
					System.out.println("가수: " + singer.get(j).text());
					System.out.println("앨범: " + album.get(j).text());
					System.out.println("포스터: " + poster.get(j).attr("src"));
					String str = etc.get(j).text();
					
					String state = str.replaceAll("[^가-힣]", "");
					String id = "";
					if(state.equals("유지")) id="0";
					else id=str.replaceAll("[^0-9]", "");
					
					System.out.println("상태: " + state);
					System.out.println("등폭: " + id);
					
					System.out.println("==================================");
				}
			}
		}catch(Exception e) {}
	}
	public static void main(String[] args) {
		GenieMusic gm = new GenieMusic();
		gm.getGenieMusic();
	}
}
