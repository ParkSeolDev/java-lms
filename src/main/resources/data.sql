insert into ns_user (id, user_id, password, name, email, created_at)
values (1, 'javajigi', 'test', '자바지기', 'javajigi@slipp.net', CURRENT_TIMESTAMP());
insert into ns_user (id, user_id, password, name, email, created_at)
values (2, 'sanjigi', 'test', '산지기', 'sanjigi@slipp.net', CURRENT_TIMESTAMP());

insert into question (id, writer_id, title, contents, created_at, deleted)
values (1, 1, '국내에서 Ruby on Rails와 Play가 활성화되기 힘든 이유는 뭘까?',
        'Ruby on Rails(이하 RoR)는 2006년 즈음에 정말 뜨겁게 달아올랐다가 금방 가라 앉았다. Play 프레임워크는 정말 한 순간 잠시 눈에 뜨이다가 사라져 버렸다. RoR과 Play 기반으로 개발을 해보면 정말 생산성이 높으며, 웹 프로그래밍이 재미있기까지 하다. Spring MVC + JPA(Hibernate) 기반으로 진행하면 설정할 부분도 많고, 기본으로 지원하지 않는 기능도 많아 RoR과 Play에서 기본적으로 지원하는 기능을 서비스하려면 추가적인 개발이 필요하다.',
        CURRENT_TIMESTAMP(), false);

insert into answer (writer_id, contents, created_at, question_id, deleted)
values (1, 'http://underscorejs.org/docs/underscore.html Underscore.js 강추합니다! 쓸일도 많고, 코드도 길지 않고, 자바스크립트의 언어나 기본 API를 보완하는 기능들이라 자바스크립트 이해에 도움이 됩니다. 무엇보다 라이브러리 자체가 아주 유용합니다.',
        CURRENT_TIMESTAMP(), 1, false);

insert into answer (writer_id, contents, created_at, question_id, deleted)
values (2, '언더스코어 강력 추천드려요. 다만 최신 버전을 공부하는 것보다는 0.10.0 버전부터 보는게 더 좋더군요. 코드의 변천사도 알 수 있고, 최적화되지 않은 코드들이 기능은 그대로 두고 최적화되어 가는 걸 보면 재미가 있습니다 :)', CURRENT_TIMESTAMP(), 1, false);

insert into question (id, writer_id, title, contents, created_at, deleted)
values (2, 2, 'runtime 에 reflect 발동 주체 객체가 뭔지 알 방법이 있을까요?',
        '설계를 희한하게 하는 바람에 꼬인 문제같긴 합니다만. 여쭙습니다. 상황은 mybatis select 실행될 시에 return object 의 getter 가 호출되면서인데요. getter 안에 다른 property 에 의존중인 코드가 삽입되어 있어서, 만약 다른 mybatis select 구문에 해당 property 가 없다면 exception 이 발생하게 됩니다.',
        CURRENT_TIMESTAMP(), false);

insert into session (id, paid_type, fee, capacity, state, start_date, end_date)
values (6, 'PAID', 800000, 3, 'RECRUITING', '2023-01-01', '2023-12-31');
insert into registration (session_id, user_id, payment_id)
values (6, 1, 1);

/*
Table에 ALTER DDL를 하게되면 Downtime이 생기므로 새로운 테이블을 생성하고 기존 테이블에서 CUD 발생 시 데이터를 마이그레이션 한다.
스트랭글러 패턴을 적용하여 as-is 서비스는 기존 테이블을 바라보고, 새로운 애플레이션은 새로운 테이블을 바라본다.
트래픽 전환이 완전히 될 때 까지는 데이터 마이그레이션(Data sync)을 아래와 같이 진행한다.
state=RECRUITING 인 경우 running_state=RUNNING, recruiting_state=RECRUITING
state=PREPARING 인 경우 running_state=PREPARING, recruiting_state=NO_RECRUITING
state=DONE 인 경우 running_state=DONE, recruiting_state=NO_RECRUITING
*/
insert into new_session (id, paid_type, fee, capacity, running_state, recruiting_state, start_date, end_date)
values (6, 'PAID', 800000, 3, 'RUNNING', 'RECRUITING', '2023-01-01', '2023-12-31');

/*
위와 동일하게 새로운 테이블에 마이그레이션 한다.
추가된 필드 selection_type, approval_type은 'Y'로 저장한다.
*/
insert into new_registration (id, session_id, user_id, payment_id, selection_type, approval_type)
values (11, 6, 1, 1, 'Y', 'Y');

insert into new_registration (id, session_id, user_id, payment_id, selection_type, approval_type)
values (12, 6, 1, 2, 'Y', 'N');
insert into new_registration (id, session_id, user_id, payment_id, selection_type, approval_type)
values (13, 6, 1, 3, 'N', 'N');