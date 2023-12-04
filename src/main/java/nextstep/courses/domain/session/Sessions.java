package nextstep.courses.domain.session;

import java.util.List;

public class Sessions {
    private final List<Session> sessions;

    private Sessions(List<Session> sessions) {
        this.sessions = sessions;
    }

    public static Sessions of(List<Session> sessions) {
        return new Sessions(sessions);
    }


    public void add(Session session) {
        sessions.add(session);
    }
}