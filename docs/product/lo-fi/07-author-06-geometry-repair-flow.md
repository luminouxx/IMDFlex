# AUTHOR-06 Geometry 수정 Deep Dive

상태: Lo-Fi 3상태 제작·연결·재검사 해결 루프 확장 완료

작성일: 2026-08-20

Figma: [Lo-Fi · 31 Screen Flow](https://www.figma.com/design/kqT9zmJTq9nOoV43y6hYqS?node-id=51-2)

## 목적

문제 위치를 본 사용자가 Geometry를 직접 수정하고, 저장 가능 여부를 이해한 뒤 재검사로 돌아가는 과정에 논리적 구멍이 없는지 검증한다. 기존 `AUTHOR-06` Ready 화면은 31개 전체 흐름의 인덱스로 보존하고, 실제 프로토타입 경로는 별도의 3상태 Deep Dive를 사용한다.

## 상태 정의

### AUTHOR-06A · 문제 진입

- 선택된 `Unit 12` Polygon 일부가 Level 경계를 벗어난 상태를 지도에서 표시한다.
- 오류 꼭짓점과 경계 밖 영역을 구분한다.
- Inspector에서 쉬운 원인 설명, 수정 위치, 저장 조건을 함께 보여준다.
- `Level 내부`가 실패하므로 저장은 차단된다.
- Primary Action은 `문제 꼭짓점 선택`이다.

### AUTHOR-06B · 수정 중

- 꼭짓점을 이동하는 중간 위치, 이전 위치, 스냅 후보를 지도에서 구분한다.
- 실행 취소를 활성화하고 다시 실행은 아직 비활성 상태로 둔다.
- `Level 내부` 조건은 `검사 중`으로 표시하며 저장은 계속 차단한다.
- Primary Action은 `이 위치에 놓기`다.

### AUTHOR-06C · 유효성 통과

- Polygon을 Level 경계 안으로 이동하고 오류 표식을 제거한다.
- 인접 Unit, 중앙 홀, `Opening 07`, Level 경계를 계속 보여 관계 맥락을 유지한다.
- `Level 내부`, 자기 교차, 인접 Unit 겹침, Opening 경계의 네 조건을 모두 통과로 표시한다.
- 삭제는 Inspector의 `Feature 삭제…` 한 곳에서만 제공한다.
- Primary Action은 `수정 저장 후 재검사`다.

## Prototype 연결

```text
REVIEW-04 문제 위치
→ AUTHOR-06A 문제 진입
→ AUTHOR-06B 수정 중
→ AUTHOR-06C 유효성 통과
→ REVIEW-05 재검사
→ REVIEW-06A 수정 성공·다른 문제 존재
→ REVIEW-06B 전체 문제 목록
→ REVIEW-04B 문제 위치·설명
```

`AUTHOR-06B` 또는 `AUTHOR-06C`에서 `변경 취소`를 누르면 `AUTHOR-06D` 확인창을 표시한다. `계속 수정`은 편집 화면으로 돌아가고, `변경 사항 버리기`는 편집 전 Geometry를 복원한 뒤 같은 문제 위치·설명 화면으로 돌아간다.

앱 내 오류가 0개가 되면 별도 결과 상태 `REVIEW-06C`를 사용한다. 이 상태는 앱 내 사전 검사 결과만 말하며 Apple IMDF Validator 통과나 제출 가능성을 보장하지 않는다.

## 검증 결과

| 검사 항목 | 결과 |
| --- | ---: |
| 기존 Ready 화면 | 31개 보존 |
| Geometry Deep Dive 화면 | 3개 |
| 재검사 해결 루프 화면 | 5개 |
| 화면 크기 | 모두 1194 × 834 |
| Prototype 연결 | 4개 |
| 남은 Placeholder | 0 |
| Noto Sans KR 외 글꼴 | 0 |

## 다음 검증 질문

1. 사용자가 첫 화면에서 어느 꼭짓점을 옮겨야 하는지 바로 이해하는가?
2. 수정 중 상태에서 이전 위치와 스냅 후보를 구분하는가?
3. 저장이 막힌 이유와 저장 가능해진 이유를 설명할 수 있는가?
4. `Opening 07`이 Unit 경계에 있어야 한다는 관계를 화면만 보고 추론하는가?
5. 저장 후 재검사가 별도 단계라는 사실을 이해하는가?
