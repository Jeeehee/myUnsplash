# SimplePhotoApp
Unsplash API와 Kakao Login API를 이용한 간단한 사진 검색 및 저장 앱

<br>

## 기능

|사진 검색|사진 저장|
|---|---|
| <img width="350" alt="이미지 제목" src="https://github.com/Jeeehee/Image/blob/main/Image/search.gif"> | <img width="350" alt="이미지 제목" src="https://github.com/Jeeehee/Image/blob/main/Image/save.gif"> |

<br>

## 아키텍쳐
MVVM + C / CleanArchitecture

- **Coordinator**

  <img width="350" alt="이미지 제목" src="https://user-images.githubusercontent.com/92635121/209908461-04642ce0-7e97-4505-966f-6632c1df83d3.png">

- **CleanArchitecture**

  <img width="1000" alt="이미지 제목" src="https://user-images.githubusercontent.com/92635121/209908453-5fb0b590-14ce-4f60-8f25-2701f6f48927.png">


<br>

## 고민과 해결
1. [AppKey를 어디에 저장할 것인가?](https://github.com/Jeeehee/myUnsplash/issues/1)  
2. [Kakao Login 초기화 진행시, AppKey를 가져오는 로직의 의존성 문제](https://github.com/Jeeehee/myUnsplash/issues/3)  
3. [ViewModel 주입 방식](https://github.com/Jeeehee/myUnsplash/issues/4)

<br>

## 트러블 슈팅
[Kakao Login Error - Admin Setting Issue(KOE101)](https://github.com/Jeeehee/myUnsplash/issues/2)
