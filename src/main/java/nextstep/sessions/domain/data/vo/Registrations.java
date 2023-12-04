package nextstep.sessions.domain.data.vo;

import java.util.ArrayList;
import java.util.List;

import nextstep.sessions.domain.exception.SessionsException;
import nextstep.users.domain.NsUser;

public class Registrations {

    private final List<Registration> registrations;

    public Registrations(List<Registration> registrations) {
        this.registrations = new ArrayList<>(registrations);
    }

    public int size() {
        return registrations.size();
    }

    public void validateDuplicateEnrollment(NsUser user) {
        if (isExist(user)) {
            throw new SessionsException("이미 수강신청된 사용자 입니다.");
        }
    }

    private boolean isExist(NsUser user) {
        return registrations.stream()
            .anyMatch(registration -> registration.hasUser(user));
    }
}