import React, { FunctionComponent, Fragment } from 'react'
import { Link } from 'react-router-dom'

interface Props {
  content: {
    link: string
    text: string
    optionText: string
    optionLink: string
  }[]
}

const CardGrid: FunctionComponent<Props> = ({ content }) => (
  <div className="flex flex-wrap justify-center items-center w-70 center pa4">
    {content.map((item) => (
      <Fragment>
        <div className="flex flex-column justify-center items-center br3 bg-near-white pa4 w-80 ma4">
          <p>{item.text}</p>
          <Link to={`${item.link}/${item.optionLink}`}>
            <p>{item.optionText}</p>
          </Link>
        </div>
      </Fragment>
    ))}
  </div>
)

export default CardGrid