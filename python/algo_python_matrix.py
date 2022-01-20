# 행렬 회전의 개념:
# 회전하는 순간 첫점과 끝점이 바뀐다. 이것을 대각 대칭한 다음 뒤집으면 된다

lst = [
    [1,2,3],
    [4,5,6],
    [7,8,9],
]
print('-------기본 행렬-------')
for i in lst:
    print(i)

print('-------전치 행렬-------')
# 전치행렬 = 대각 대칭
lst2 = list(map(list,zip(*lst)))
for i in lst2:
    print(i)

print('-------반시계 90도-------')
# 반시계 90도 (대각대칭 후 위아래 뒤집기)
lst3 = list(zip(*lst))[::-1]
for i in lst3:
    print(i)

print('-------시계 90도-------')
# 시계 90도 (위아래 뒤집고 대각 대칭)
lst4 = list(zip(*lst[::-1]))
# lst[::-1] 이게 먼저 적용되고 *로 풀어진다
for i in lst4:
    print(i)
    
print('-------예시-------')
a=list(lst[::-1])
for i in a:
    print(i)
