getText = function getText(e) {
  let data
  const articleUUID = e.target.getAttribute('data-article-uuid')
  const text = (document.all) ? document.selection.createRange().text : document.getSelection();
  const startChar = document.getSelection().anchorOffset - 20
  const endChar = document.getSelection().extentOffset - 20
  const texString = text.toString()
  if(articleUUID &&  texString !== '' && texString.length >= 3) {
    const x = e.offsetX + 128
    const y = e.offsetY + 128
    data = {
      xPos: x, 
      yPos: y,
      articleUUID: articleUUID,
      startChar: startChar, endChar: endChar,
      selectedText: texString
    }
  }
  return data
}