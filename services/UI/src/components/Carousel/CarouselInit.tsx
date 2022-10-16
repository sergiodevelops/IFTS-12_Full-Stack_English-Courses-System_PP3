import React from 'react';
import Carousel from 'react-bootstrap/Carousel';
import 'bootstrap/dist/css/bootstrap.min.css';
import { carouselData } from '@constants/contentData';
import useStyles from "./styles";

export default function CarouselInit() {
    const classes = useStyles();

    return (
        <Carousel
            onClick={()=> window.location.href = '/#inicio'}
            fade className={classes.root}>
            <Carousel.Item about={carouselData.infoimagen1}>
                <img
                    className={`${classes.imagen} d-block w-100 h-50`}
                    src={carouselData.imageUrl1}
                    alt="First slide"
                />
                <Carousel.Caption>
                    <h3>{carouselData.infoimagen1}</h3>
                    <p>{carouselData.descripcion1}</p>
                </Carousel.Caption>
            </Carousel.Item>
            <Carousel.Item>
                <img
                    className={`${classes.imagen} d-block w-100 h-50`}
                    src={carouselData.imageUrl2}
                    alt="Second slide"
                />

                <Carousel.Caption>
                    <h3>{carouselData.infoimagen2}</h3>
                    <p>{carouselData.descripcion2}</p>
                </Carousel.Caption>
            </Carousel.Item>
            <Carousel.Item>
                <img
                    className={`${classes.imagen} d-block w-100 h-50`}
                    src={carouselData.imageUrl3}
                    alt="Third slide"
                />

                <Carousel.Caption>
                    <h3>{carouselData.infoimagen3}</h3>
                    <p>{carouselData.descripcion3}</p>
                </Carousel.Caption>
            </Carousel.Item>
        </Carousel>
    );
}
