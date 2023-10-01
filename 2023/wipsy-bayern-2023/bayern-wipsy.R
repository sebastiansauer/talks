d <- read_csv("/Users/sebastiansaueruser/github-repos/talks/wipsy-bayern-2023/data/WiPsy-Bachelor-Bayern-Präsenz.csv")

d2 <-
  d %>% 
  mutate(geo = map(Ort, getbb))


unpack_geo <- function(geodata){
  geodata %>% 
    as_tibble() %>% 
    mutate(avg = min + (min - max)/2) %>% 
    mutate(geo = c("long", "lat")) %>% 
    select(geo, avg) %>% 
    pivot_wider(names_from = geo, values_from = avg)
}

d4 <-
  d2 %>% 
  mutate(geo2 = map(geo, unpack_geo)) %>% 
  select(-geo) %>% 
  unnest(geo2)

write_csv(d4, "wipsy-bayern-geo.csv")
