import { useEffect, useState } from "react";
import Apis, { endpoints } from "../../configs/Apis";

const useEvent = (initialQuery = "") => {
    const [events, setEvents] = useState([]);
    const [loading, setLoading] = useState(false);
    const [page, setPage] = useState(1);
    const [q, setQ] = useState(initialQuery);
    const [hasMore, setHasMore] = useState(true);

    const loadEvents = async () => {
        if (!hasMore || loading) return;
        try {
            setLoading(true);
            let url = `${endpoints["events"]}?page=${page}`;
            if (q.trim() !== "") {
                url += `&q=${q.trim()}`;
            }
            const res = await Apis.get(url);
            setEvents(prev => [...prev, ...res.data.results]);
            if (!res.data.next) setHasMore(false);
        } catch (err) {
            console.error("Lỗi tải sự kiện:", err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadEvents();
    }, [page]);

    const loadMore = () => {
        if (!loading && hasMore) setPage(prev => prev + 1);
    };

    return { events, loading, loadMore };
};

export default useEvent;
