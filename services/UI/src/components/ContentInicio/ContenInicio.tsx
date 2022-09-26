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
// !import datos:
import { presentacionInicio, cardsInfo } from './ContentData';

const Item = styled(Paper)(({ theme }) => ({
    backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
    ...theme.typography.body2,
    padding: theme.spacing(1),
    textAlign: 'center',
    color: theme.palette.text.secondary,
}));
// RowAndColumnSpacing:
export default function ContentInicio() {
    return (
        <Container maxWidth="xl">
            <br></br>
            <Item>
                <h1>{presentacionInicio.titulo}</h1>
                <p>{presentacionInicio.descripcion}</p>
            </Item>
            <br></br>
            <Card sx={{ width: '100%' }}>
                <Grid
                    container
                    rowSpacing={3}
                    columnSpacing={{ xs: 1, sm: 2, md: 3 }}
                >
                    {/*content 1 */}

                    {cardsInfo.data.map((card) => {
                        const { titulo, descripcion, imageUrl } = card;
                        return (
                            <Grid item xs={6}>
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
