const fs = require('fs') // require file system
const componentName = process.argv[2]; // first and second command line args are locked

// react class component boiler plate
const jsContent = `import React, { Component } from 'react';
import './${componentName}.css';

class ${componentName} extends Component {
    constructor(props) {
        super(props);
        this.state = { };
    }

    handleClick = () => this.setState({ clicked: true });

    render(){
        const { props, state } = this;
        return(
            <div className="${componentName}">
                ${componentName}
            </div>
        )
    } 
}
export default ${componentName};
`

// css boilerplate
const cssContent = `
.${componentName}{

}
.${componentName}-title{

}

.${componentName}-img{

}

.${componentName}-misc{

}

`
fs.writeFile(`${componentName}.css`, cssContent, err => {
  if (err) {
    console.error(err)
    return
  }
  //file written successfully
})

// write the files to the same directory
fs.writeFile(`${componentName}.js`, jsContent, err => {
  if (err) {
    console.error(err)
    return
  }
  //file written successfully
})

