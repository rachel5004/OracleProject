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
					System.out.println("¼øÀ§: "+k);
					System.out.println("Á¦¸ñ: " + title.get(j).text());
					System.out.println("°¡¼ö: " + singer.get(j).text());
					System.out.println("¾Ù¹ü: " + album.get(j).text());
					System.out.println("Æ÷½ºÅÍ: " + poster.get(j).attr("src"));
					String str = etc.get(j).text();
					
					String id = "";
					String state = str.replaceAll("[^°¡-ÆR]", ""); // ÇÑ±Û»©°í ´Ù Á¦°Å
					
					if(state.equals("À¯Áö")) id="0";
					else if(str.equals("new")) id="0";
					else id=str.replaceAll("[^0-9]", "");
					
					System.out.println("»óÅÂ: " + state);
					System.out.println("µîÆø: " + id);
					
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
