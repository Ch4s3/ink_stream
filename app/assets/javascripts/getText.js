getText = function getText(e) {
  let data
  const articleUUID = e.target.getAttribute('data-article-uuid')
  const text = (document.all) ? document.selection.createRange().text : document.getSelection();
  const startChar = document.getSelection().anchorOffset - 20
  const endChar = document.getSelection().extentOffset - 20
  if(articleUUID && text.toString() !== '') {
    const x = e.offsetX + 16
    const y = e.clientY + 8
    data = {
      xPos: x, 
      yPos: y,
      articleID: articleUUID,
      startChar: startChar, endChar: endChar,
      selectedText: text.toString()
    }
  }
  return data
}