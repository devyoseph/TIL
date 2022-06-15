# 비동기

​               

### 1. Chaining 처리, Hard Code

> A 메서드가 종료된 이후 B 메서드를 실행

####  - promise를 사용한 HardCode

* promise & then을 이용해 메서드가 실행 완료되면 다음 메서드 실행

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)
    }, delay)
  })
}


delay_word('SAMSUNG', 500).then((resolve) => {

	console.log(resolve)

	delay_word('SW', 490).then((resolve) => { 

		console.log(resolve)
		
		delay_word('ACADEMY', 480).then((resolve) => {
			
			console.log(resolve)

			delay_word('FOR', 470).then((resolve) => {

				console.log(resolve)

				delay_word('YOUTH', 460).then((resolve) => {

					console.log(resolve)
				})
			})
		})
	})
})

```

​               

#### - async 를 이용한 SoftCode

* async & await을 이용해 순차적으로 메서드를 실행

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)
    }, delay)
  })
}


async function test(){
	const resolve_0 = await delay_word('SAMSUNG', 500)
	console.log(resolve_0)
	const resolve_1 = await delay_word('SW', 490)
	console.log(resolve_1)
	const resolve_2 = await delay_word('ACADEMY', 480)	
	console.log(resolve_2)
	const resolve_3 = await delay_word('FOR', 470)
	console.log(resolve_3)
	const resolve_4 = await delay_word('YOUTH', 460)
	console.log(resolve_4)
}

test()
```

​                

### 2.  Chaining 처리, Soft Code

> 입력값이 가변적일 때는 Soft Code로 구현

#### - promise를 이용한 SoftCode

* reduce를 활용해 배열 내부에 정보를 넣고 실행할 수 있다.

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)      
    }, delay)
  })
}


const array = [{word:'SAMSUNG', delay:500}, {word:'SW', delay:490}, {word:'ACADEMY', delay:480}, {word:'FOR', delay:470}, {word:'YOUTH', delay:460}]

array.reduce((prev, item) => {

	return prev.then(() =>
		delay_word(item.word, item.delay).then((promise) => {console.log(promise)}))

}, Promise.resolve())
```

​               

#### - async를 이용한 SoftCode

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)      
    }, delay)
  })
}


const array = [{word:'SAMSUNG', delay:500}, {word:'SW', delay:490}, {word:'ACADEMY', delay:480}, {word:'FOR', delay:470}, {word:'YOUTH', delay:460}]

async function test(){

	for(const item of array) {
		const resolve = await delay_word(item.word, item.delay)
	
		console.log(resolve)				
	}
}

test()
```

​                 

### 3. All 처리, 비순차

> then() 이나 await를 사용하지 않는다. 

#### - promise 활용

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)
    }, delay)
  })
}


const array = [{word:'SAMSUNG', delay:500}, {word:'SW', delay:490}, {word:'ACADEMY', delay:480}, {word:'FOR', delay:470}, {word:'YOUTH', delay:460}]


array.forEach(async (item) => {
	
	delay_word(item.word, item.delay).then((resolve) => {console.log(resolve)})			
})
```

​                

#### - async 활용

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)
    }, delay)
  })
}


const array = [{word:'SAMSUNG', delay:500}, {word:'SW', delay:490}, {word:'ACADEMY', delay:480}, {word:'FOR', delay:470}, {word:'YOUTH', delay:460}]


array.forEach(async (item) => {
	
	const resolve = await delay_word(item.word, item.delay)
	
	console.log(resolve)
	
})
```

​                  

### 4. All 처리, 순차

> 비동기 작업을 병렬로 정렬하고 싶거나 비동기 작업들을 깔끔하게 한번에 출력하기 위해 사용한다.
> Promise.all 을 이용한다.

#### - promise 활용

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)
    }, delay)
  })
}


const array = [{word:'SAMSUNG', delay:500}, {word:'SW', delay:490}, {word:'ACADEMY', delay:480}, {word:'FOR', delay:470}, {word:'YOUTH', delay:460}]

const promise_list = []

array.forEach((item) => {

	const promise = delay_word(item.word, item.delay)

	promise_list.push(promise)
})

Promise.all(promise_list).then((values) => {

	values.forEach((resolve) => {console.log(resolve)})
})
```

​             

#### - async 사용

* 각각의 실행을 메서드로 묶고 그 메서드에 async 부여

```js
function delay_word(word, delay) {
  return new Promise(resolve => {
    setTimeout(function (){
      resolve(word)
    }, delay)
  })
}


const array = [{word:'SAMSUNG', delay:500}, {word:'SW', delay:490}, {word:'ACADEMY', delay:480}, {word:'FOR', delay:470}, {word:'YOUTH', delay:460}]


async function test(){
	
	const async_fun_list = []

	for(item of array){	
	
		const async_fun = delay_word(item.word, item.delay)
	
		async_fun_list.push(async_fun)
	}
		
	for(async_fun of async_fun_list){
		
		const resolve = await async_fun
		
		console.log(resolve)
	}		
}

	
test()
```

