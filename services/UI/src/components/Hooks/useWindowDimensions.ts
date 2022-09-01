import { useState, useEffect } from 'react';

export default function useWindowDimensions() {

    const hasWindow = typeof window !== 'undefined';

    function getWindowDimensions() {
        const viewportWith = hasWindow ? window.innerWidth : null;
        const viewportHeight = hasWindow ? window.innerHeight : null;
        return {
            viewportWith,
            viewportHeight,
        };
    }

    const [windowDimensions, setWindowDimensions] = useState(getWindowDimensions());

    useEffect(() => {
        if (hasWindow) {
            const handleResize=() =>{
                setWindowDimensions(getWindowDimensions());
            }

            window.addEventListener('resize', handleResize);
            return () => window.removeEventListener('resize', handleResize);
        }
    }, [hasWindow]);

    return windowDimensions;
}