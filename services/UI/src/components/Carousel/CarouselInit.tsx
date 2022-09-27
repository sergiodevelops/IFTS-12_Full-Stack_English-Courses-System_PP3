import React from 'react';
import Carousel from 'react-bootstrap/Carousel';
import 'bootstrap/dist/css/bootstrap.min.css';

import { carouselData } from '../../assets/ContentData';

function CarouselInit() {
    return (
        <Carousel fade>
            <Carousel.Item>
                <img
                    className="d-block w-100"
                    src={carouselData.imageUrl1}
                    alt="First slide"
                />
                <Carousel.Caption>
                    <h3>{carouselData.infoimagen1}</h3>
                    <p>
                        Nulla vitae elit libero, a pharetra augue mollis
                        interdum.
                    </p>
                </Carousel.Caption>
            </Carousel.Item>
            <Carousel.Item>
                <img
                    className="d-block w-100 h-50"
                    src={carouselData.imageUrl2}
                    alt="Second slide"
                />

                <Carousel.Caption>
                    <h3>{carouselData.infoimagen2}</h3>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                    </p>
                </Carousel.Caption>
            </Carousel.Item>
            <Carousel.Item>
                <img
                    className="d-block w-100 h-50"
                    src={carouselData.imageUrl3}
                    alt="Third slide"
                />

                <Carousel.Caption>
                    <h3>{carouselData.infoimagen3}</h3>
                    <p>
                        Praesent commodo cursus magna, vel scelerisque nisl
                        consectetur.
                    </p>
                </Carousel.Caption>
            </Carousel.Item>
        </Carousel>
    );
}

export default CarouselInit;
