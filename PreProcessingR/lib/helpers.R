fn_uu = function(jenis, tahun){
  perundangan = jenis
  tahun = tahun
  full_url = paste0("http://www.dpr.go.id/jdih/", perundangan, "/year/", tahun)
  page = read_html(full_url)
  
  tabel = page %>% 
    html_table(fill = TRUE)
  tabel = tabel[[1]]
  
  # URL 
  link = page %>%
    html_nodes("div:nth-child(1) > a") %>% 
    html_attr("href") %>% 
    data_frame()
  colnames(link) = "url"
  
  link = link %>% 
    filter(str_detect(url, ".pdf")) %>% 
    mutate(url = paste0("http://www.dpr.go.id", url))
  
  df = bind_cols(tabel, link)
  df = df %>% 
    select(-DOKUMEN)
  colnames(df) = c("no", "judul", "url_pdf")
  rm(tabel, page, link)
  return(df)
}