# 전체 31개 화면 Component Lo-Fi

상태: 전체 Lo-Fi의 31개 Ready 기반 화면 · 이후 82개 Screen Family로 확장 완료

작성일: 2026-08-20

Figma: [Lo-Fi · 31 Screen Flow](https://www.figma.com/design/kqT9zmJTq9nOoV43y6hYqS?node-id=51-2)

## 목적

승인된 8개 핵심 화면의 Component-Identifiable Lo-Fi 기준을 전체 End-to-End Happy Path로 확장한다. 시각적 완성도보다 화면 간 논리, 작업 맥락, 실제 조작 요소의 식별 가능성, 문제 해결과 내보내기의 닫힌 흐름을 검증한다.

## 제작 범위

기존 기준 화면 8개를 보존하고 별도의 Figma 페이지에 복제했다. 나머지 23개 화면을 새로 제작해 총 31개 화면을 문서의 Wireflow 순서대로 배치했다.

### A. 프로젝트 및 공간 설정

1. `HOME-01` 최근 프로젝트
2. `CREATE-01` 시작 방식
3. `CREATE-02` 프로젝트 기본 정보
4. `SETUP-02` 주소 검색
5. `SETUP-03` 지도 확인
6. `SETUP-04` Venue 정보
7. `SETUP-05` 건물 목록
8. `SETUP-06` 건물 정보
9. `SETUP-08` 층 목록
10. `SETUP-09` 층 정보

### B. 평면도 및 프로젝트 개요

11. `FLOOR-01` 평면도 허브
12. `FLOOR-02` 평면도 가져오기
13. `FLOOR-04` 수동 정렬
14. `EDIT-01` 프로젝트 개요

### C. 편집기 및 Feature 작성

15. `EDIT-02` 편집기 셸
16. `AUTHOR-01` Feature 선택기
17. `AUTHOR-02` Polygon 그리기
18. `AUTHOR-05` 연속 작성
19. `AUTHOR-08` Feature 인스펙터
20. `AUTHOR-11` 관계 선택기
21. `AUTHOR-12` 지도 관계 모드

### D. 검토, 수정 및 내보내기

22. `REVIEW-01` 문제 요약
23. `REVIEW-03` 문제 상세
24. `REVIEW-04` 문제 위치
25. `AUTHOR-06` Geometry 선택 및 편집
26. `REVIEW-05` 재검사
27. `REVIEW-06` 재검사 결과
28. `EXPORT-01` 내보내기 허브
29. `EXPORT-02` 제출 전 검사
30. `EXPORT-06` 내보내기 진행
31. `EXPORT-07` 내보내기 성공

## Component Lo-Fi 표현

- 선택 방식은 텍스트 설명 대신 선택 Card와 선택 상태로 표현했다.
- 주소 설정은 Search Input, 결과 List Row, Map, Marker로 표현했다.
- Venue·건물·층 설정은 실제 Form Control과 관계·상태 Card로 표현했다.
- 평면도 작업은 파일 Drop Zone, 층별 파일 List, Map, Building Outline, 반투명 Floor-plan Overlay, 정렬 Control로 표현했다.
- 작성 작업은 Feature List, Map Canvas, Polygon, Opening, Vertex Handle, Drawing Tool, Inspector로 표현했다.
- 관계 작성은 검색 가능한 대상 List와 지도 위 관계 후보 Marker로 표현했다.
- 검토는 Severity Badge, Summary Card, Issue Row, 문제 위치 Map으로 표현했다.
- 내보내기는 유형별 Export Card, Preflight 결과, Progress Bar, File Detail과 공유 Control로 표현했다.

## Prototype 연결

31개 화면의 Primary Action은 문서 순서대로 연결된다. `REVIEW-04`와 `REVIEW-05` 사이에는 Geometry 수정의 판단 과정을 검증하기 위한 3상태 Deep Dive가 삽입된다. 마지막 `EXPORT-07`은 `HOME-01`로 돌아가 하나의 닫힌 End-to-End Loop를 만든다.

```text
HOME-01 → CREATE-01 → CREATE-02 → SETUP-02 → SETUP-03
→ SETUP-04 → SETUP-05 → SETUP-06 → SETUP-08 → SETUP-09
→ FLOOR-01 → FLOOR-02 → FLOOR-04 → EDIT-01 → EDIT-02
→ AUTHOR-01 → AUTHOR-02 → AUTHOR-05 → AUTHOR-08 → AUTHOR-11
→ AUTHOR-12 → REVIEW-01 → REVIEW-03 → REVIEW-04
→ AUTHOR-06A 문제 진입 → AUTHOR-06B 수정 중 → AUTHOR-06C 유효성 통과
→ REVIEW-05 → REVIEW-06 → EXPORT-01 → EXPORT-02 → EXPORT-06
→ EXPORT-07 → HOME-01
```

## 검증 결과

| 검사 항목 | 결과 |
| --- | ---: |
| Screen 수 | 31 |
| 화면 크기 | 모두 1194 × 834 |
| 비어 있는 Screen | 0 |
| 남은 Placeholder | 0 |
| Primary Action | 31 |
| Prototype Reaction | 31 |
| Noto Sans KR 외 글꼴 | 0 |
| ASCII Wireframe 문자 | 0 |
| 리터럴 줄바꿈 문자 | 0 |

프로젝트 생성, 주소 검색, 도면 정렬, 관계 선택, 문제 요약, Geometry 편집, 재검사, 내보내기 성공의 대표 화면을 개별 캡처로 확인했다. 전체 페이지 축소 캡처에서도 31개 화면이 순서대로 배치되고 주요 UI 구조가 일관되게 유지된다.

추가된 `AUTHOR-06` Deep Dive는 3개 Frame, 4개 연결(`REVIEW-04` 진입과 `REVIEW-05` 이탈 포함), Noto Sans KR 외 글꼴 0개, 남은 Placeholder 0개로 검증했다. 기존 31개 Ready Frame은 모두 보존했다.

## 후속 확장 완료

이 문서는 31개 대표 Ready 화면의 제작 기록이다. 아래 예외 흐름은 이후 Coverage Matrix를 기준으로 별도 Frame 또는 화면 내부 상태로 추가 완료했다.

- Draft Project 취소와 폐기
- 주소 검색 Offline·Error
- Geometry 완료 차단과 취소
- 잘못된 관계 대상
- 재검사 실패 또는 남은 오류
- 제출 차단과 경고 확인
- ZIP 생성 실패와 재시도

## 현재 기준 문서

전체 확장과 최종 검증은 `10-lofi-completion-report.md`, `11-final-coverage-matrix.md`를 기준으로 한다. 다음 작업은 Task-based 사용성 테스트이며, 그 전까지 시각 디자인과 제품 디자인 토큰 작업은 보류한다.
