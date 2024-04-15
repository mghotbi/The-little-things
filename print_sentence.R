sentence <- " ¯\\_(ツ)_/¯  ¯\\_(ツ)_/¯  ¯\\_(ツ)_/¯  ¯\\_(ツ)_/¯  ¯\\_(ツ)_/¯ ¯\\_(ツ)_/¯ ¯\\_(ツ)_/¯ ¯\\_(ツ)_/¯ ¯\\_(ツ)_/¯  ¯\\_(ツ)_/¯ "

print_sentence <- function(sentence) {
  for (i in 1:10) { 
    cat(sentence, "\n")
  }
}

sentence %>% print_sentence()
