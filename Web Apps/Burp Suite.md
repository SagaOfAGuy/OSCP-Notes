## Burp Suite - Sniper/Battering Ram Attack
Attack for when you know either the username or password, but only **1**, **NOT** both

1. Select Either **Battering Ram** or **Sniper** for the attack type


![image](https://user-images.githubusercontent.com/68156940/210181791-90342301-6b69-428e-9ddc-fb3bf993f2e8.png)

2. Make sure that the `§` symbols are placed around the variable that we want to enumerate. In our case, this would be the `password` field. 
3. Load the password list in the `payload` tab

![image](https://user-images.githubusercontent.com/68156940/210181859-5141192a-6f4b-4532-95ea-821b7b50ff69.png)

4. Press the `Start Attack` button to start. 
5. Iterate through the responses until you find a successful login page

![image](https://user-images.githubusercontent.com/68156940/210181899-53873b8b-b557-4e4c-97c4-b7422ec1762b.png)


