#!/bin/bash
set -e

OUTPUT=slideshow.html
STYLE=style.css
CONTENT=pldi.md

exec 1>"$OUTPUT"

cat <<'EOF'
<!DOCTYPE html>
<html>
  <head>
    <title>
EOF
sed -n '/^ *#/!b;s/^ *# *//p;q' "$CONTENT"
cat <<'EOF'
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link rel="stylesheet" href="katex/katex.min.css">
<script src="katex/katex.min.js"></script>
<script src="katex/contrib/auto-render.js"></script>
    <style type="text/css">
EOF
cat "$STYLE"
cat <<'EOF'
    </style>
  </head>
  <body onload="var slideshow = remark.create({countIncrementalSlides: false, highlightLines: true}, function() {
        renderMathInElement(document.body);
});">
    <textarea id="source" style="display:none">
EOF
cat "$CONTENT"
cat <<'EOF'
    </textarea>
    <script type="text/javascript">
EOF
sed 's#"</script>"#"</"+"script>"#'  remark-latest.min.js
cat <<'EOF'
    </script>
  </body>
</html>
EOF
