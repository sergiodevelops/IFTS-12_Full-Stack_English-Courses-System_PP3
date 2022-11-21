import React from 'react';
import { makeStyles, Theme, createStyles } from '@material-ui/core/styles';
import clsx from 'clsx';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Avatar from '@material-ui/core/Avatar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import chesterIcon from "@assets/images/chester-institute-icon.png";
import {Grid} from "@material-ui/core";

const useStyles = makeStyles((theme: Theme) =>
    createStyles({
        root: {
            width: "50vw",
            margin: "2rem 0",
            textAlign: "center",
            display: "block",
            wordBreak: "break-word",

        },
        imagen: {
            width: "100%",
            opacity: ".8"
        },
        media: {
            height: 0,
            paddingTop: '56.25%', // 16:9
        },
        expand: {
            transform: 'rotate(0deg)',
            marginLeft: 'auto',
            transition: theme.transitions.create('transform', {
                duration: theme.transitions.duration.shortest,
            }),
        },
        expandOpen: {
            transform: 'rotate(180deg)',
        },
        avatar: {
            cursor: "pointer",
            minHeight: "40px",
            '& .css-1y942vo-MuiButtonBase-root-MuiButton-root': {
                fontWeight: "bolder",
            }
        },
    }),
);

export type INewCardProps = {
    title: string,
    description: string,
    index?: number,
    date?: string,
    avatar?: boolean,
}

export default function NewCard(props: INewCardProps) {
    const {title, description} = props;
    const classes = useStyles();
    const [expanded, setExpanded] = React.useState(false);

    const handleExpandClick = () => {
        setExpanded(!expanded);
    };

    return (
        <Grid
            container
            key={`${props.index || 0}-${title}`}
            justifyContent={"center"}
        >

        <Card elevation={2} className={classes.root}>

            <CardHeader
                avatar={
                    props.avatar !== false &&
                    <Avatar aria-label="recipe" className={classes.avatar}>
                        <img  className={classes.imagen} src={chesterIcon}/>
                    </Avatar>
                }
                action={
                    <IconButton aria-label="settings">
                    </IconButton>
                }
                title={
                <Typography variant={'h5'}>
                    {title.toUpperCase()}
                </Typography>
            }
                subheader={props.date || ""}
            />
            <CardContent>
                <Typography variant="body2" color="textSecondary" component="p">
                    {description}
                </Typography>
            </CardContent>
            <CardActions disableSpacing>
                <IconButton aria-label="add to favorites">
                </IconButton>
                <IconButton aria-label="share">
                </IconButton>
                <IconButton
                    className={clsx(classes.expand, {
                        [classes.expandOpen]: expanded,
                    })}
                    onClick={handleExpandClick}
                    aria-expanded={expanded}
                    aria-label="show more"
                >
                </IconButton>
            </CardActions>
        </Card>
        </Grid>
    );
}
