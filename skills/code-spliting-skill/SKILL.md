---
name: code-spliting-skill
description: 코드를 편집할 때, 코드를 분리하는 기준에 대한 스킬입니다.
---

## 용어 정의

### 카테고리 폴더

관심사를 담고 있는 폴더를 `카테고리 폴더` 라고 지칭하며 아래는 그 예시이다.

```text
components/ <-- 특정 도메인별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
  ㄴ user-form/ <-- 카테고리 폴더임.
    ㄴ index.ts <-- `export * from './user-form`, .js 확장자를 붙일지 말지는 프로젝트 환경에 맞출 것.
    ㄴ user-form.tsx
hooks/ <-- 특정 도메인별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
  ㄴ book-hooks/ <-- 특정 도메인별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
    ㄴ use-book-modify-handler/ <-- 카테고리 폴더임.
      ㄴ index.ts <-- `export * from './use-book-modify-handler`, .js 확장자를 붙일지 말지는 프로젝트 환경에 맞출 것.
      ㄴ use-book-modify-handler.tsx
```

카테고리 폴더 밑에 또 다른 카테고리 폴더가 위치할 수도 있다. `파일 분리 규칙` 항목에 예시가 있다.

## 하나의 파일에 라인수가 200을 넘지 않도록 한다

하나의 파일의 라인수가 200줄을 초과한 경우, 본 문서의 `파일 분리 규칙`에 맞춰 파일을 분리해야한다.

## 파일 분리 규칙

관심사 별로 서브 카테고리 폴더를 만들어 코드를 분리한다. 아래는 그 예시이다.

```text
components/
  ㄴ user-form/
    ㄴ _components/ <-- 서브 카테고리 폴더들을 특정 도메인 기준으로 그룹핑한 폴더.
      ㄴ user-basic-info-form/ <-- 카테고리 폴더
        ㄴ index.ts
        ㄴ user-basic-info-form.tsx
      ㄴ user-detail-info-form/ <-- 카테고리 폴더
        ㄴ index.ts
        ㄴ user-detail-info-form.tsx
    ㄴ index.ts
    ㄴ user-form.tsx
```

- 서브 카테고리 폴더들은 앞에 \_(언더바)가 붙는 그룹핑 폴더 밑에 선언하며, 해당 카테고리 폴더에서만 사용되는 것들을 선언한다. 위 예시 같은 경우 `user-basic-info-form/`, `user-detail-info-form/` 이 2개 카테고리 폴더는 `user-form.tsx` 에서만 사용된다.
- 서브 카테고리 폴더 밑의 파일 또한 200 라인이 넘어갈 경우 또 서브 카테고리로 분리하면 된다.

## 배럴 익스포트는 카테고리 폴더 바로 밑의 index.ts 에서만 허용

배럴 익스포트는 카테고리 폴더 바로 밑의 index.ts 에서만 허용합니다. 아래 예시처럼 도메인별로 그룹핑 되어 있는 여러 카테고리 폴더들을 배럴 익스포트로 내보내면 안됩니다.

```text
src/functions/
  ㄴ my-function-1/
    ㄴ _utils/
      ㄴ my-util-1/
        ㄴ my-util-1.ts
        ㄴ index.ts         # ✅ 카테고리 폴더 자신의 index.ts
      ㄴ my-util-2/
        ㄴ my-util-2.ts
        ㄴ index.ts         # ✅ 카테고리 폴더 자신의 index.ts
      ㄴ index.ts           # ❌ 여러 카테고리를 모아 내보내는 것 금지
    ㄴ my-function-1.ts
    ㄴ index.ts             # ✅ 카테고리 폴더 자신의 index.ts
  ㄴ my-function-2/...
  ㄴ index.ts               # ❌ 여러 카테고리를 모아 내보내는 것 금지
```
