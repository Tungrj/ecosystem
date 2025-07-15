library(readr)

df <- read_csv(xxx)

# --- Prepare Data ------------------------------------------------------------

codes <- df[[1]]
mat_norm <- as.matrix(df[ , 2:ncol(df)])
rownames(mat_norm) <- codes
mode(mat_norm) <- "numeric"
doc_ids <- colnames(df)[-1]
doc_ids <- sub("\nGr=.*", "", doc_ids) 

# --- Binarize Data ----------------------------------------------------------

# Convert to presence/absence: 1 if normalized count > 0, else 0
mat_bin <- (mat_norm > 0) * 1

# --- Compute Saturation ------------------------------------------------------

n_docs   <- ncol(mat_bin)
cum_new  <- integer(n_docs)
seen     <- logical(nrow(mat_bin))

for (j in seq_len(n_docs)) {
  present    <- mat_bin[ , j] == 1
  new_here   <- present & !seen
  cum_new[j] <- sum(new_here)
  seen       <- seen | present
}

cum_codes <- cumsum(cum_new)

# --- Plot Saturation Curve --------------------------------------------------

plot(seq_len(n_docs), cum_codes, type = "b",
     xlab = "Document #", ylab = "Cumulative Unique Codes",
     main = "Saturation Curve")

text(seq_len(n_docs), cum_codes, labels = doc_ids, pos = 3, cex = 1.2)

threshold <- 0.95 * max(cum_codes)
abline(h = threshold, col = "blue", lty = 2)
first95 <- which(cum_codes >= threshold)[1]


segments(x0 = first95, y0 = 0, x1 = first95, y1 = cum_codes[first95],
         col = "blue", lty = 2)

text(first95 + 0.55, cum_codes[first95] - 1,
     paste0("Doc ", first95), col = "blue")

