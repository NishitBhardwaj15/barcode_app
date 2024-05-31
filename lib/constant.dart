const String baseApi = "http://13.232.149.183/api/v1";

const Map<int, String> errorMessages={
  400:"Bad request",
  200:"Your request has been succesfully executed",
  404:"Resource not found, please enter valid request",
  403:"Session has expired, please login to continue",

  //Custom Messages
  700:"Not allowed to take attendnace. Start taking attendance",
  701:"Duplicate request"
};

const token = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX1RFQUNIRVIifV0sInN1YiI6ImRpZ2FudGFiYWlzaHlhIiwiaWF0IjoxNzE3MDU4NDM4LCJleHAiOjE3MTgzNTQ0Mzh9.VdmcxggWQz3e7bcG8ncDS8el6-ZlcATI0hq3yb3tGa0";