CREATE PROCEDURE spDivideTwoNumber
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  SET @Result = @Number1 / @Number2
  PRINT 'RESULT IS :'+CAST(@Result AS VARCHAR)
END

EXEC spDivideTwoNumber 100, 5
EXEC spDivideTwoNumber 100, 0		--Not terminated Result is 0

--Using RAISERROR System Function

ALTER PROCEDURE spDivideTwoNumber
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  IF(@Number2 = 0)
  BEGIN
    RAISERROR('Second Number Cannot be zero',16,1)
  END
  ELSE
  BEGIN
    SET @Result = @Number1 / @Number2
    PRINT 'RESULT IS :'+CAST(@Result AS VARCHAR)
  END
END

EXEC spDivideTwoNumber 100, 0

--Using @@Error System Function
ALTER PROCEDURE spDivideTwoNumber
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  IF(@Number2 = 0)
  BEGIN
    RAISERROR('Second Number Cannot be zero',16,1)
  END
  ELSE
  BEGIN
    SET @Result = @Number1 / @Number2
  END
  IF(@@ERROR <> 0)
  BEGIN
    PRINT 'Error Occurred'
  END
  ELSE
  BEGIN
    PRINT 'RESULT IS :'+CAST(@Result AS VARCHAR)
  END
END

EXEC spDivideTwoNumber 100, 0

-- Raise error using RAISERROR statement

CREATE PROCEDURE spDivideBy1(@No1 INT, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    IF @No2 = 1
    RAISERROR ('DIVISOR CANNOT BE ONE', 16, 1)
    SET @Result = @No1 / @No2
    PRINT 'THE RESULT IS: '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT ERROR_NUMBER()
    PRINT ERROR_MESSAGE()
    PRINT ERROR_SEVERITY()
    PRINT ERROR_STATE()
  END CATCH
END

 EXEC spDivideBy1 10, 1

 --Raise Error using throw statement 

ALTER PROCEDURE spDivideBy1(@No1 INT, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    IF @No2 = 1
    THROW 50001,'DIVISOR CANNOT BE ONE', 1
    SET @Result = @No1 / @No2
    PRINT 'THE RESULT IS: '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT ERROR_NUMBER()
    PRINT ERROR_MESSAGE()
    PRINT ERROR_SEVERITY()
    PRINT ERROR_STATE()
  END CATCH
END

EXEC spDivideBy1 10, 1

--using the TRY CATCH
CREATE PROCEDURE spDivideTwoNumbers
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    SET @Result = @Number1 / @Number2
    PRINT 'RESULT IS : '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT 'SECOND NUMBER SHOULD NOT BE ZERO'
  END CATCH
END

EXEC spDivideTwoNumbers 10, 2
EXEC spDivideTwoNumbers 10, 0

-- try-catch with system defined error statements
ALTER PROCEDURE spDivideTwoNumbers
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    SET @Result = @Number1 / @Number2
    PRINT 'RESULT IS : '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT ERROR_MESSAGE()
  END CATCH
END

EXEC spDivideTwoNumbers 10, 0
