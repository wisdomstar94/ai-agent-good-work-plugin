---
name: code-splitting-skill
description: 코드를 편집할 때 적용하는 파일 · 폴더 분리 기준 스킬입니다.
---

## 용어 정의

### 카테고리 폴더

관심사 하나를 담고 있는 폴더를 `카테고리 폴더` 라고 부릅니다. 아래는 그 예시입니다.

```text
components/ <-- 종류별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
  ㄴ user-form/ <-- 카테고리 폴더임.
    ㄴ index.ts <-- `export * from './user-form'` (import 경로의 .js 확장자 표기 여부는 프로젝트 설정을 따름)
    ㄴ user-form.tsx
hooks/ <-- 종류별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
  ㄴ book-hooks/ <-- 도메인별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
    ㄴ use-book-modify-handler/ <-- 카테고리 폴더임.
      ㄴ index.ts <-- `export * from './use-book-modify-handler'` (import 경로의 .js 확장자 표기 여부는 프로젝트 설정을 따름)
      ㄴ use-book-modify-handler.tsx
```

카테고리 폴더 안에 `_` 로 시작하는 그룹핑 폴더를 두고, 그 밑에 서브 카테고리 폴더를 둘 수 있습니다. 서브 카테고리 폴더도 카테고리 폴더의 한 종류이므로 카테고리 폴더 규칙이 똑같이 적용됩니다. 예시는 `파일 분리 규칙` 항목에 있습니다.

## 한 파일이 200줄을 넘지 않게 하세요

한 파일이 200줄을 넘으면 이 스킬의 `파일 분리 규칙` 에 맞춰 파일을 분리해야 합니다.

## 파일 분리 규칙

관심사별로 서브 카테고리 폴더를 만들어 코드를 분리합니다. 아래는 그 예시입니다.

```text
components/
  ㄴ user-form/
    ㄴ _components/ <-- 서브 카테고리 폴더들을 종류별로 그룹핑한 폴더.
      ㄴ user-basic-info-form/ <-- 서브 카테고리 폴더임.
        ㄴ index.ts
        ㄴ user-basic-info-form.tsx
      ㄴ user-detail-info-form/ <-- 서브 카테고리 폴더임.
        ㄴ index.ts
        ㄴ user-detail-info-form.tsx
    ㄴ index.ts
    ㄴ user-form.tsx
```

- 서브 카테고리 폴더는 이름 앞에 `_`(언더스코어)가 붙는 그룹핑 폴더 밑에 두고, 상위 카테고리 폴더에서만 쓰는 것들을 담습니다. 위 예시에서 `user-basic-info-form/` 과 `user-detail-info-form/` 두 서브 카테고리 폴더는 `user-form.tsx` 에서만 쓰입니다.
- 서브 카테고리 폴더 밑의 파일도 200줄을 넘으면 같은 방식으로 다시 서브 카테고리로 분리합니다.

## 배럴 익스포트는 카테고리 폴더 바로 밑의 index.ts 에서만 허용합니다

아래 예시처럼 그룹핑 폴더나 상위 폴더에서 여러 카테고리 폴더를 모아 배럴 익스포트로 내보내면 안 됩니다.

```text
src/functions/
  ㄴ my-function-1/
    ㄴ _utils/
      ㄴ my-util-1/
        ㄴ index.ts <-- ✅ 카테고리 폴더 자신의 index.ts
        ㄴ my-util-1.ts
      ㄴ my-util-2/
        ㄴ index.ts <-- ✅ 카테고리 폴더 자신의 index.ts
        ㄴ my-util-2.ts
      ㄴ index.ts <-- ❌ 여러 카테고리 폴더를 모아 내보내는 것 금지
    ㄴ index.ts <-- ✅ 카테고리 폴더 자신의 index.ts
    ㄴ my-function-1.ts
  ㄴ my-function-2/...
  ㄴ index.ts <-- ❌ 여러 카테고리 폴더를 모아 내보내는 것 금지
```
