package com.sist.music;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class GenieMusic {
	public void getGenieMusic() {
		try {
			MusicDAO dao = new MusicDAO();
			int k=201;
			for(int i=1;i<=2;i++) {
				//Document doc = Jsoup.connect("https://www.genie.co.kr/chart/top200?ditc=D&ymd=20210210&hh=14&rtm=Y&pg="+i).get();
				Document doc = Jsoup.connect("https://www.genie.co.kr/chart/top200?ditc=D&ymd=20210210&hh=14&rtm=Y&pg="+i).get();
				
				
				//title, singer, album, states, idcrement, rank
				Elements title = doc.select("tr.list a.title");
				Elements singer = doc.select("tr.list a.artist");
				Elements album = doc.select("tr.list a.albumtitle");
				Elements poster = doc.select("tr.list a.cover img");
				Elements etc = doc.select("tr.list span.rank");
				for(int j=0;j<title.size();j++) {
					System.out.println("순위: "+k);
					System.out.println("제목: " + title.get(j).text());
					System.out.println("가수: " + singer.get(j).text());
					System.out.println("앨범: " + album.get(j).text());
					System.out.println("포스터: " + poster.get(j).attr("src"));
					String str = etc.get(j).text();
					
					String id = "";
					String state = str.replaceAll("[^가-힣]", ""); // 한글빼고 다 제거
					
					if(state.equals("유지")) id="0";
					else if(str.equals("new")) id="0";
					else id=str.replaceAll("[^0-9]", "");
					
					System.out.println("상태: " + state);
					System.out.println("등폭: " + id);
					
					System.out.println("==================================");
					GenieMusicVO vo = new GenieMusicVO();
					vo.setNo(k);
					vo.setCno(2);
					vo.setTitle(title.get(j).text());
					vo.setSinger(singer.get(j).text());
					vo.setAlbum(album.get(j).text());
					vo.setPoster(poster.get(j).attr("src"));
					vo.setState(state);
					vo.setIdcrement(Integer.parseInt(id));
					
					dao.genieMusicInsert(vo);
					Thread.sleep(100);
					k++;
					
				}
			}
		}catch(Exception e) {}
	}
	public static void main(String[] args) {
		GenieMusic gm = new GenieMusic();
		gm.getGenieMusic();
	}
}
