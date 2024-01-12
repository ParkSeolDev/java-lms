package nextstep.qna.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import nextstep.qna.UnAuthorizedException;
import nextstep.users.domain.NsUserTest;

public class AnswersTest {
	List<Answer> answerList;

	@BeforeEach
	void create() {
		answerList = new ArrayList<>();
		answerList.add(new Answer(new TextBody(NsUserTest.JAVAJIGI, "Answers Contents1", false), QuestionTest.Q1));
	}

	@Test
	@DisplayName("답변 목록 중 질문자와 답변자 다른경우가 있으면 에러를 던짐")
	void 다른_사람이_쓴_답변_존재() {
		answerList.add(new Answer(new TextBody(NsUserTest.SANJIGI, "Answers Contents2", false), QuestionTest.Q1));
		Answers answers = new Answers(answerList);

		assertThrows(UnAuthorizedException.class, () -> answers.checkAuthorization(NsUserTest.JAVAJIGI));
	}

	@Test
	@DisplayName("답변 목록을 모두 삭제 상태로 바꾼 후 삭제 히스토리 리스트 리턴")
	void delete_성공() {
		Answers answers = new Answers(answerList);
		List<DeleteHistory> deleteHistories = new ArrayList<>();

		assertThat(answers.delete(deleteHistories))
			.containsOnly(new DeleteHistory(ContentType.ANSWER, null, NsUserTest.JAVAJIGI, LocalDateTime.now()));
	}

	@Test
	@DisplayName("답변을 추가할 수 있는지 확인")
	void 답변_추가() {
		Answers answers = new Answers(answerList);
		Answers result = answers.add(new Answer(new TextBody(NsUserTest.JAVAJIGI, "Answers Contents2", false), QuestionTest.Q1));

		answerList.add(new Answer(new TextBody(NsUserTest.JAVAJIGI, "Answers Contents2", false), QuestionTest.Q1));
		Answers matchList = new Answers(answerList);

		assertThat(result).isEqualTo(matchList);
	}
}
