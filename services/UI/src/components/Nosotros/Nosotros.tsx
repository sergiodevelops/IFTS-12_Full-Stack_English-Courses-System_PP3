import * as React from 'react';
import { styled } from '@mui/material/styles';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';
import { CardActionArea } from '@mui/material';
import {nosotrosInfo} from "@constants/contentData";

const Item = styled(Paper)(({ theme }) => ({
    backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
    ...theme.typography.body2,
    padding: theme.spacing(1),
    textAlign: 'center',
    color: theme.palette.text.secondary,
}));

export type NosotrosProps = {
    nosotros: string,
    presentacion: string
}

export default function Nosotros(props: NosotrosProps) {
    const { presentacion, nosotros } = props;

    return (
        <Container maxWidth="xl">
            <br></br>
            <br></br>
            <Item>
                <h1>{nosotros}</h1>
                <p>{presentacion}</p>
            </Item>
            <br></br>
            <Card sx={{ width: '100%' }}>
                <Grid
                    container
                    rowSpacing={3}
                    columnSpacing={{ xs: 1, sm: 2, md: 3 }}
                >
                    {/* Tarjetas: */}

                    {nosotrosInfo.data.map((data: any, index: any) => {
                        const { titulo, descripcion, imageUrl } = data;

                        return (
                            <Grid item xs={6} key={index}>
                                <CardActionArea>
                                    <CardMedia
                                        component="img"
                                        height="200"
                                        image={imageUrl}
                                        alt="green iguana"
                                    />
                                    <CardContent>
                                        <Typography
                                            gutterBottom
                                            variant="h5"
                                            component="div"
                                        >
                                            {titulo}
                                        </Typography>
                                        <Typography
                                            variant="body2"
                                            color="text.secondary"
                                        >
                                            {descripcion}
                                        </Typography>
                                    </CardContent>
                                </CardActionArea>
                            </Grid>
                        );
                    })}
                </Grid>
            </Card>
            <br></br>
            <br></br>
            <br></br>
        </Container>
    );
}
