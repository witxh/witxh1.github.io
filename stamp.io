<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>온라인 스탬프 판</title>
  <style>
    body {
      font-family: sans-serif;
      margin: 20px;
    }
    .board {
      display: flex;
      flex-wrap: wrap; /* 화면이 좁으면 줄바꿈 */
      gap: 20px;
      margin-top: 30px;
      justify-content: center;
    }
    .stamp {
      width: 120px;
      height: 120px;
      border: 2px dashed #aaa;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 24px;
      cursor: pointer;
      transition: all 0.3s ease;
    }
    .stamped {
      background-color: lightgreen;
      border: 2px solid green;
      font-weight: bold;
      cursor: default;
    }

    /* 📱 모바일 화면 대응 */
    @media (max-width: 600px) {
      .stamp {
        width: 80px;
        height: 80px;
        font-size: 18px;
      }
    }
  </style>
</head>
<body>
  <h1>온라인 스탬프 판</h1>
  <p>스탬프 칸을 눌러주세요!</p>
  <div class="board">
    <div class="stamp" data-id="1">1</div>
    <div class="stamp" data-id="2">2</div>
    <div class="stamp" data-id="3">3</div>
    <div class="stamp" data-id="4">4</div>
  </div>

  <script>
    // 각 칸별 비밀번호 설정
    const passwords = {
      1: "0713",
      2: "0101",
      3: "0606",
      4: "2568"
    };

    const stamps = document.querySelectorAll(".stamp");

    // 저장된 상태 불러오기
    const savedStamps = JSON.parse(localStorage.getItem("myStamps")) || {};

    stamps.forEach(stamp => {
      const id = stamp.getAttribute("data-id");

      // 이미 저장된 상태라면 표시
      if (savedStamps[id]) {
        stamp.classList.add("stamped");
        stamp.textContent = "✔";
      }

      stamp.addEventListener("click", () => {
        // 이미 찍힌 칸은 무시
        if (stamp.classList.contains("stamped")) {
          return;
        }

        const input = prompt(`관리자 비밀번호를 입력하세요 (칸 ${id}) :`);
        if (input === passwords[id]) {
          stamp.classList.add("stamped");
          stamp.textContent = "✔";
          alert("Very Good!");

          // 상태 저장
          savedStamps[id] = true;
          localStorage.setItem("myStamps", JSON.stringify(savedStamps));
        } else {
          alert("비밀번호가 틀렸습니다.");
        }
      });
    });
  </script>
</body>
</html>
