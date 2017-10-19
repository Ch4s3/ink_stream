// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const AnnotationForm = props => (
  <div className='annotation-form'>
    wow
  </div>
)

AnnotationForm.defaultProps = {
  name: ''
}

AnnotationForm.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  const articleFomrDiv = document.querySelector('.article-form');
  if(articleFomrDiv){
    ReactDOM.render(<AnnotationForm name="React" />, articleFomrDiv)
  }
})
