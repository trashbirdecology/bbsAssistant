update_sb_items <- function(bbs_par_id = "52b1dfa8e4b0d9b325230cd9",
                            res_par_id = "5ea835e082cefae35a1fada7"){
  bbs_ch <- sbtools::item_list_children(bbs_par_id)

  bbs_ch_hist <- sbtools::item_list_children(bbs_ch[[2]]$id)

  res_ch <- sbtools::item_list_children(res_par_id)

  make_df <- function(x){
    df <- data.frame(sb_parent = x$parentId, sb_item = x$id,
                     sb_title = x$title, sb_link = x$link$url)

    df %>%
      dplyr::mutate(
        release_year = stringr::str_extract(sb_title, "(\\d\\d\\d\\d.*) Release", group = 1),
        year_start = stringr::str_extract(sb_title, "(\\d\\d\\d\\d).?-.?\\d\\d\\d\\d", group = 1),
        year_end = stringr::str_extract(sb_title, "\\d\\d\\d\\d.?-.?(\\d\\d\\d\\d)", group = 1),
        data_type = ifelse(stringr::str_detect(sb_title, "esults"), "results", "observations"),
        legacy_format = ifelse(stringr::str_detect(sb_title, "legacy"), "y", "n")
      )
  }

  lst_items <- c(list(bbs_ch[[1]]), bbs_ch_hist, res_ch)

  new_sb_items <- lapply(lst_items, make_df) %>% dplyr::bind_rows()

  if(is.null(sb_items)){
    sb_items <- data.frame(sb_item = letters[1:10])
  }

  add_rows <- dplyr::anti_join(new_sb_items, sb_items, by = "sb_item")

  if(nrow(add_rows) > 0){
    message("returning sb_items with", nrow(add_rows), " new rows")

   return(new_sb_items)
  } else {
    return(sb_items)
  }
}
