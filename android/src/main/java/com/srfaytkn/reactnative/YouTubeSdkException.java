package com.srfaytkn.reactnative;

public class YouTubeSdkException extends RuntimeException {

  private String message;

  public YouTubeSdkException(String message) {
    super(message);
    this.message = message;
  }

  @Override
  public String getMessage() {
    return message;
  }
}
