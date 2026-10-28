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

## 코드는 사용처 가까이에 두세요

200줄 분리와 상관없이, 새로 만드는 코드는 모두 아래 기준으로 위치를 정합니다.

- **한 곳에서만 쓰는 코드** 는 사용처와 같은 경로의 `_components/` · `_utils/` · `_hooks/` 등 그룹핑 폴더 밑에 카테고리 폴더로 둡니다.
- **두 곳 이상에서 쓰는 코드** 는 사용처들의 **공통 상위 경로** 의 그룹핑 폴더 밑에 둡니다.
- 공통 상위 경로가 앱 전체(예: Next.js 의 `src/app/`)일 때만 `src/components/` · `src/utils/` · `src/hooks/` 같은 공용 폴더에 둡니다.
- 사용처에는 카테고리 폴더뿐 아니라 **라우트 폴더**(Next.js app router 의 `page.tsx` · `layout.tsx` 가 있는 폴더 등)도 포함됩니다.
- 사용처가 늘거나 줄어 기준이 바뀌면, 그 작업에서 코드를 맞는 경로로 옮깁니다.

```text
src/app/(auth-required)/access-policy-groups/
  ㄴ _components/
    ㄴ access-policy-groups-screen/ <-- 이 폴더의 page.tsx 에서만 쓰므로 여기에 둠.
      ㄴ index.ts
      ㄴ access-policy-groups-screen.tsx
    ㄴ access-policy-group-editor/ <-- new/page.tsx 와 [groupId]/page.tsx 에서 쓰므로 공통 상위인 여기에 둠.
      ㄴ index.ts
      ㄴ access-policy-group-editor.tsx
  ㄴ [groupId]/
    ㄴ page.tsx
  ㄴ new/
    ㄴ page.tsx
  ㄴ page.tsx
src/components/
  ㄴ page-heading/ <-- 여러 라우트에서 쓰고 공통 상위가 src/app/ 이므로 공용 폴더에 둠.
```

## 파일을 만들거나 수정할 때 위치를 확인하세요

- 새 파일을 만들기 전에 사용처를 먼저 정하고, `코드는 사용처 가까이에 두세요` 기준에 맞는 경로에 만듭니다.
- 기존 파일을 수정할 때도 그 파일의 사용처와 위치가 기준에 맞는지 확인합니다.
- 기존 코드베이스의 관례가 이 기준과 어긋나더라도, 그 관례를 따라 새 코드를 만들지 마세요.
- 어긋난 기존 코드를 발견하면 작업 범위를 임의로 넓혀 옮기지 말고, 작업계획서의 `결정 필요` 나 완료 보고에 적어 사용자에게 알립니다.

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
