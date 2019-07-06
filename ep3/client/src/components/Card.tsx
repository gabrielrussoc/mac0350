import React, { FunctionComponent } from 'react'
import { Link } from 'react-router-dom'

const Card: FunctionComponent<{ content: any }> = ({ content }: any) => (
  <Link to={content.route}>
    <div className="flex justify-center items-center br3 pa4 bg-white w-75">
      <p>{content.text}</p>
    </div>
  </Link>
)

export default Card