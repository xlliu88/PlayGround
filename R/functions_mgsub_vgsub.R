mgsub <- function(x, ..., fmode = TRUE) {
  # x, a vector you want to do replacement on
  # take various numbers of 2-elements vectors:
  #     first element: characters ought to be replaced
  #     second element: the replacement
  # fmode: TRUE = no regular expression
  #        FALSE = regular expression
  
  args <- list(...)
  for (s in args) {
    if (length(s) < 2) {
      stop("length of replacement vector is less then 2")
      }
    else if (length(s) > 2) {
      cat("length of replacement vector is larger then 2. only the first two were taken")
      }
    x <- gsub(s[1], s[2], x, fixed = fmode)
    }
  return(x)
}

vgsub <- function(x, v_pattern, v_replacement, fmode = TRUE) {
  # x, a vector you want to do replacement on
  # v_pattern, a vector of character/strings ought to be replaced
  # v_replacement, a vector of replacement
  # v_pattern and v_replacement should be with the same length
  
  if (!length(v_pattern)== length(v_replacement)) {
    stop("Vector of pattern and Vector of replacement have different length")
    }
  
  for (i in 1: length(v_pattern)){
    x <- gsub(v_pattern[i], v_replacement[i], x, fixed = fmode)
    }
  return(x)
}




vo <- LastMonth$Description

v1 <- c(":", "CTR", "MO", "WEB")
v2 <- c("****", "########","MOMOMOMO", "WEEEEEEEEB")
vr <- vgsub(vo, v1, v2, fmode = TRUE)

vm1 <- c(":","****")
vm2 <- c("CTR","######")
vm3 <- c("MO", "MOMOMOMO")
vm4 <- c("WEB","WEEEEEEB")
vr2 <- mgsub(vo, v1, v2, v3, v4, fmode = TRUE)
