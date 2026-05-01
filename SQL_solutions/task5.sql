-- =============================================
-- Task 5
-- Goal: create procedure to add a client with duplicate check.
-- =============================================
IF OBJECT_ID('sp_AddClient', 'P') IS NOT NULL
    DROP PROCEDURE sp_AddClient;
GO

CREATE PROCEDURE sp_AddClient
    @ClientID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM CLIENTS WHERE ClientID = @ClientID)
    BEGIN
        RAISERROR('Client with the given ClientID already exists.', 16, 1);
        RETURN;
    END;

    INSERT INTO CLIENTS (ClientID, FirstName, LastName, Email)
    VALUES (@ClientID, @FirstName, @LastName, @Email);

    SELECT 'Client inserted successfully.' AS Message;
END;
GO

-- Example:
-- EXEC sp_AddClient 1001, 'Alex', 'Stone', 'alex.stone@example.com';
