// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class AnnotationForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { 
      annotationText: '',
      articleUUID: '',
      citation: '',
      visible: false,
      startChar: null,
      endChar: null,
      selectedText: '',
      xPos: '',
      yPos: ''
    };
    this.setAnnotation = this.setAnnotation.bind(this);
    this.setCitation = this.setCitation.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.hide = this.hide.bind(this);
    this.postData = this.postData.bind(this);
  }
  componentDidMount() {
    const _this = this
    const articleText = document.querySelector('.article-text');
    if(articleText) {
      articleText.addEventListener('mouseup', function(e) { _this.handleSelect(e) });
    }
  }
  render() {
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    const formStyle = {
      padding: '1rem',
      backgroundColor: '#4EB9FF',
    }
    const style = {
      color: '#00080C',
      maxWidth: '34rem',
      zIndex: 100,
      position: 'absolute',
      top: this.state.yPos,
      left: this.state.xPos
    }

    const selection = this.state.selectedText
    let form
    if (this.state.visible === true) {
      form = 
        <div style={formStyle}>
          <h4>annotation</h4>
          <blockquote style={{fontSize: '1rem'}}>
            {selection}
          </blockquote>
          <form onSubmit={this.handleSubmit}>
            <fieldset>
              <label for='annotation-form-annotation-text'>Annotation</label>
              <textarea id='annotation-form-annotation-text'
                name='annotations_form[annotation_text]' 
                onChange={this.setAnnotation}
                value={this.state.annotationText}
              />
              <label for='annotation-form-citation-text'>Citation</label>
              <input type='text' id='annotation-form-citation-text'
                onChange={this.setCitation}
                name='annotations_form[citation_text]'
                value={this.state.citation}
              />
              <button className='button button-outline'>
                submit
              </button>
            </fieldset>
          </form>
        </div>
    }
    return (
      <div style={style}>
        {form}
      </div>
    );
  }
  setAnnotation(e) {
    this.setState({ annotationText: e.target.value });
  }

  setCitation(e) {
    this.setState({ citation: e.target.value });
  }

  handleSelect(e) {
    const data = getText(e);
    if(data) {
      this.setState({
        visible: true,
        articleUUID: data.articleUUI,
        citation: data.citatio,
        startChar: data.startChar,
        endChar: data.endChar,
        selectedText: data.selectedText,
        xPos: data.xPos,
        yPos: data.yPos
      })
    } else {
      this.hide()
    }
  }

  hide() {
    this.setState({visible: false})
  }

  handleSubmit(e) {
    e.preventDefault();
    this.postData();
  }

  postData(e) {
    const request = new XMLHttpRequest();
    request.open('POST', '/annotations', true);
    request.setRequestHeader('Content-Type', 'application/json')
    request.onload = function() {
      if (request.status === 200) {
        this.hide();
        const resData = JSON.parse(request.responseText);
        console.log(resData)
      } else {
        const resData = JSON.parse(request.responseText);
        console.log(resData)
      }
    };
    
    request.onerror = function(e) {
      console.log(e);
    };
    const data = {
      annotations_form: { text: this.state.annotationText, citation: this.state.citation}
    }
    request.send(JSON.stringify(data))
  }
}


document.addEventListener('turbolinks:load', () => {
  const articleFomrDiv = document.querySelector('.article-form');
  if(articleFomrDiv){
    ReactDOM.render(<AnnotationForm articleUUID="12345" />, articleFomrDiv)
  }
})
