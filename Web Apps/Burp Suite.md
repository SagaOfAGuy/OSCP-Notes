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


## Burp Suite - Pitchfork Attack
Attack for when a site has more security features like sessions IDs and cookies. 

1. Choose the **Pitchfork** attack option. 

![image](https://user-images.githubusercontent.com/68156940/210188058-089a6458-16e2-480b-816f-0983b46460ae.png)

2. Create the payloads for each respective parameter. In our case, this would be the `cookie` value, `set_session` field, password/username field, and the `token` field as seen above. 
3. For the `set session` and `token` fields, create a recursive grep by click the **Options** tab > **Grep - Payloads** tab, and grab the values for `set_session` value, and `cookie` value by defining the **Start at expression** and **End at delimeter** expressions. 

![image](https://user-images.githubusercontent.com/68156940/210188159-69968569-9094-4266-804c-708730c33e28.png)

Grabbing the recursive expressions: 

![image](https://user-images.githubusercontent.com/68156940/210188182-62384ae6-f6aa-43c6-9bb7-d713efddca51.png)

**NOTE**: Before running the attack, create a custom resource pool. Using the default resource pool does **NOT** work! 

![image](https://user-images.githubusercontent.com/68156940/210188261-7967b39b-2ba5-416a-933e-df39fdc97f47.png)



4. Run the attack by clicking **Start Attack**

![image](https://user-images.githubusercontent.com/68156940/210188234-c01e91dc-a509-4f0a-8c13-44213572dcfe.png)

If the results for an entry yields a **302** status, then that means that the password/username combo is correct and those are the correct credentials to login. 
