USE [master]
GO
/****** Object:  Database [PRJ301_SU24_PlanMenu]    Script Date: 7/10/2024 2:06:53 AM ******/
CREATE DATABASE [PRJ301_SU24_PlanMenu]
GO

USE [PRJ301_SU24_PlanMenu]
GO

ALTER DATABASE [PRJ301_SU24_PlanMenu] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRJ301_SU24_PlanMenu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET RECOVERY FULL 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET  MULTI_USER 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PRJ301_SU24_PlanMenu', N'ON'
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET QUERY_STORE = ON
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PRJ301_SU24_PlanMenu]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 7/10/2024 2:06:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](50) NOT NULL,
	[description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 7/10/2024 2:06:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NOT NULL,
	[product_id] [int] NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/10/2024 2:06:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date] [varchar](255) NULL,
	[address] [nvarchar](max) NULL,
	[phonenumber] [varchar](255) NULL,
	[totalmoney] [float] NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 7/10/2024 2:06:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](MAX) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[category_id] [int] NULL,
	[image_url] [nvarchar](500) NULL,
	[quantity_in_stock] [int] NOT NULL,
	[quantity_sold] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 7/10/2024 2:06:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[product_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[rating] [int] NULL,
	[comment] [nvarchar](255) NULL,
	[review_date] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/10/2024 2:06:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[full_name] [varchar](100) NULL,
	[phone_number] [varchar](20) NULL,
	[isAdmin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([category_id], [category_name], [description]) VALUES (1, N'Main dishes', N'Các món chính thường là phần chính của bữa ăn')
INSERT [dbo].[Categories] ([category_id], [category_name], [description]) VALUES (2, N'Side dishes', N'Các món phụ đi kèm với món chính để bổ sung hương vị')
INSERT [dbo].[Categories] ([category_id], [category_name], [description]) VALUES (3, N'Desserts', N'Các món tráng miệng thường được dùng sau bữa ăn chính')
INSERT [dbo].[Categories] ([category_id], [category_name], [description]) VALUES (4, N'Beverages', N'Các loại đồ uống giải khát, cà phê, nước ép')
INSERT [dbo].[Categories] ([category_id], [category_name], [description]) VALUES (5, N'Appetizers', N'Các món khai vị được dùng để kích thích vị giác trước bữa ăn chính')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (1, N'Hamburger', N'Shape ground beef into patties and season with salt and pepper. Grill the patties for 4-5 minutes on each side until fully cooked. Toast the hamburger buns on the grill. Assemble the hamburger by placing the patty on the bottom bun, adding lettuce, tomato slices, and any desired condiments, then top with the other bun.', CAST(8.99 AS Decimal(10, 2)), 1, N'https://vinpro.store/wp-content/uploads/2022/07/cach-lam-banh-Hamburger-5.jpg', 50, 20)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (2, N'Caesar Salad', N'Wash and chop romaine lettuce. Prepare Caesar dressing by mixing olive oil, lemon juice, Worcestershire sauce, garlic, Dijon mustard, and anchovy paste. Toss the lettuce with the dressing. Add croutons and grated Parmesan cheese on top.', CAST(6.49 AS Decimal(10, 2)), 2, N'https://www.thespruceeats.com/thmb/DRaBINVopeoHOpjJn66Yh7pMBSc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-caesar-salad-recipe-996054-Hero_01-33c94cc8b8e841ee8f2a815816a0af95.jpg', 30, 15)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (3, N'Chocolate Cake', N'Preheat the oven to 350°F (175°C). Mix flour, sugar, cocoa powder, baking powder, baking soda, and salt in a bowl. In another bowl, mix eggs, milk, vegetable oil, and vanilla extract. Combine the wet and dry ingredients and mix until smooth. Pour into a greased cake pan and bake for 30-35 minutes. Let cool and frost with chocolate icing.', CAST(12.99 AS Decimal(10, 2)), 3, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFASb_66xiP3Gc4Ucdun-wI5CwzOhSIxWS8g&s', 20, 10)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (4, N'Iced Coffee', N'Brew a strong pot of coffee. Let the coffee cool to room temperature, then chill in the refrigerator. Fill a glass with ice cubes, pour the chilled coffee over the ice, and add cream and sugar to taste.', CAST(3.99 AS Decimal(10, 2)), 4, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqLs454hVyYfUYn9l3LVmP8T_0-0Kjf3AODw&s', 40, 30)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (5, N'Spring Rolls', N'Soak rice paper in warm water until pliable. Lay out the rice paper and add a layer of fresh lettuce, cooked shrimp, vermicelli noodles, and julienned vegetables (carrots, cucumbers, bell peppers). Roll tightly, folding in the sides. Serve with a dipping sauce made from hoisin sauce, peanut butter, and a splash of water.', CAST(5.99 AS Decimal(10, 2)), 5, N'https://www.thespruceeats.com/thmb/LAD6HCmf0MFSpV3JDJgM9n7REos=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/SES-thai-fresh-rolls-with-vegetarian-option-3217706-hero-A-3bdb04a8ee2444a2ab6873810a334642.jpg', 25, 12)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (6, N'Pizza', N'Preheat the oven to 475°F (245°C). Roll out pizza dough on a floured surface. Spread tomato sauce evenly over the dough. Sprinkle shredded mozzarella cheese and arrange pepperoni slices on top. Bake in the oven for 10-12 minutes until the crust is golden brown and the cheese is bubbly.', CAST(10.99 AS Decimal(10, 2)), 1, N'https://thucphamsieuthi.vn/wp-content/uploads/2021/08/banh-pizza-hai-san-dong-lanh.jpg', 60, 25)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (7, N'Chicken Wings', N'Preheat the oven to 400°F (200°C). Season chicken wings with salt, pepper, and your favorite spices. Place wings on a baking sheet lined with parchment paper. Bake for 25-30 minutes, turning halfway through. Toss the cooked wings in buffalo sauce made from hot sauce, melted butter, and garlic powder.', CAST(7.99 AS Decimal(10, 2)), 2, N'https://www.allrecipes.com/thmb/AtViolcfVtInHgq_mRtv4tPZASQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/ALR-187822-baked-chicken-wings-4x3-5c7b4624c8554f3da5aabb7d3a91a209.jpg', 45, 18)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (8, N'Cheesecake', N'Preheat the oven to 325°F (165°C). Mix graham cracker crumbs, melted butter, and sugar to make the crust. Press the mixture into the bottom of a springform pan. Beat cream cheese, sugar, and vanilla extract until smooth. Add eggs one at a time, mixing well after each addition. Pour the filling over the crust and bake for 55-60 minutes. Cool and top with strawberry sauce.', CAST(9.99 AS Decimal(10, 2)), 3, N'https://www.onceuponachef.com/images/2017/12/cheesecake-1200x1393.jpg', 15, 8)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (9, N'Smoothie', N'Combine frozen mixed fruits (berries, bananas, mangoes), yogurt, and a splash of orange juice in a blender. Blend until smooth. Pour into a glass and serve immediately.', CAST(4.99 AS Decimal(10, 2)), 4, N'https://www.eatingwell.com/thmb/KCDDSEVOd4pRYoDokPJ4cUuwLxI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/EWL-57793-berry-kefir-smoothie-Hero-01-A-ae9e20c50f1843928b81c102bfa80b4c.jpg', 35, 28)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (10, N'Sushi Roll', N'Cook sushi rice and season with rice vinegar, sugar, and salt. Place a nori sheet on a bamboo mat. Spread a thin layer of rice on the nori, leaving a border at the top. Add slices of fish, cucumber, and avocado. Roll tightly using the bamboo mat. Slice the roll into pieces and serve with soy sauce.', CAST(11.49 AS Decimal(10, 2)), 5, N'https://www.allrecipes.com/thmb/XT7-9MROYJZvNyQR4J40HGOVDmQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/19511smoked-salmon-sushi-rollfabeveryday4x3-159a22b4d3ac49fe9a146db94b53c930.jpg', 30, 15)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (11, N'Lasagna', N'Preheat the oven to 375°F (190°C). Cook lasagna noodles according to package instructions. Prepare meat sauce by sautéing ground beef with onions and garlic, then add tomato sauce and simmer. In a bowl, mix ricotta cheese, egg, and grated Parmesan. In a baking dish, layer noodles, meat sauce, ricotta mixture, and shredded mozzarella. Repeat layers and finish with mozzarella. Bake for 45 minutes.', CAST(13.99 AS Decimal(10, 2)), 1, N'https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&w=1528&h=764&url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F848496.jpg', 20, 10)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (12, N'Tiramisu', N'Brew strong espresso and let cool. Mix mascarpone cheese, sugar, and a splash of coffee liqueur. Dip ladyfingers in the espresso and layer in a dish. Spread the mascarpone mixture over the ladyfingers. Repeat layers and top with cocoa powder. Chill in the refrigerator for at least 4 hours before serving.', CAST(14.99 AS Decimal(10, 2)), 3, N'https://www.onceuponachef.com/images/2022/12/Tiramisu-760x1015.jpg', 15, 8)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (13, N'Grilled Cheese Sandwich', N'Butter one side of each bread slice. Place one slice, butter side down, in a hot skillet. Add a layer of cheese and top with the other slice, butter side up. Cook until the bread is golden brown and the cheese is melted, flipping once.', CAST(5.49 AS Decimal(10, 2)), 1, N'https://www.simplyrecipes.com/thmb/uf00aXhTP5xP6x8mn7DU0ylA6Q8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Grilled-Cheese-LEAD-02-58c2fcb124c44d779b0f9815c6d3aa5e.jpg', 50, 25)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (14, N'Tacos', N'Cook ground beef with taco seasoning until fully browned. Warm taco shells in the oven. Fill each shell with beef, shredded lettuce, diced tomatoes, shredded cheese, and any additional toppings like sour cream or guacamole.', CAST(7.99 AS Decimal(10, 2)), 1, N'https://www.thespruceeats.com/thmb/uDHFTHfO7fbM-T9zuv-7MOGG7oY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-tacos-4690614-hero-01-fd8e1d3d8be04473b7db96f2cda3d90d.jpg', 40, 22)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (15, N'Pancakes', N'In a bowl, mix flour, sugar, baking powder, and a pinch of salt. In another bowl, whisk together milk, egg, and melted butter. Combine the wet and dry ingredients until just mixed. Heat a lightly oiled griddle over medium-high heat. Pour batter onto the griddle, using approximately 1/4 cup for each pancake. Cook until bubbles form on the surface, then flip and cook until golden brown.', CAST(4.99 AS Decimal(10, 2)), 4, N'https://www.seriouseats.com/thmb/L7dA_UBU0uN00_qiFNX6esS0mQc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/20210607-fluffy-pancakes-vicky-wasik-16-2d154e3a0cb14df3bc66c666170f7e1e.jpg', 60, 30)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (16, N'BBQ Ribs', N'Preheat oven to 300°F (150°C). Rub ribs with a mixture of brown sugar, paprika, salt, and pepper. Place ribs on a baking sheet, cover with aluminum foil, and bake for 2.5 to 3 hours. Remove from oven, brush with BBQ sauce, and grill for an additional 5-10 minutes until sauce is caramelized.', CAST(15.99 AS Decimal(10, 2)), 2, N'https://www.simplyrecipes.com/thmb/lzdxobZBfJoS5nnLDdfz2NxwH6g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Oven-Baked-BBQ-Ribs-LEAD-4-fc3a9db2855a4e2496f4c32ed9631291.jpg', 20, 10)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (17, N'Garlic Bread', N'Preheat oven to 375°F (190°C). In a bowl, mix softened butter, minced garlic, and chopped parsley. Spread the mixture over halved French bread. Place bread on a baking sheet and bake for 10-15 minutes until golden brown.', CAST(3.99 AS Decimal(10, 2)), 1, N'https://www.simplyrecipes.com/thmb/7hlS4xVKn0E7fjKTUyeOV89Cn5U=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Garlic-Bread-LEAD-8-60ba6b3d15b04963bb2ddfbab8051f42.jpg', 50, 25)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (18, N'Spaghetti Bolognese', N'Cook spaghetti according to package instructions. In a skillet, sauté onions and garlic in olive oil until translucent. Add ground beef and cook until browned. Pour in tomato sauce, add herbs (basil, oregano), and simmer for 20 minutes. Serve sauce over cooked spaghetti and top with grated Parmesan cheese.', CAST(10.49 AS Decimal(10, 2)), 1, N'https://www.simplyrecipes.com/thmb/7S4uygWiRh_D5bPVo4UzRPvhOrU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Spaghetti-Bolognese-LEAD-4-a2782bbf5c51431c95e19fa15e8fbd5b.jpg', 40, 20)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (19, N'Macarons', N'Sift almond flour and powdered sugar together. Whisk egg whites until stiff peaks form, then fold in the dry ingredients. Pipe small circles onto a baking sheet lined with parchment paper. Let sit for 30 minutes to form a skin. Bake at 300°F (150°C) for 15-18 minutes. Cool and fill with buttercream or ganache.', CAST(13.99 AS Decimal(10, 2)), 3, N'https://www.simplyrecipes.com/thmb/SnBEmCkJqvwW9upvVUlHTjqGlIc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Macarons-LEAD-6-1fb73c84e9a94cdaac94ac6c3e7fbb8e.jpg', 20, 10)
INSERT [dbo].[Products] ([product_id], [product_name], [description], [price], [category_id], [image_url], [quantity_in_stock], [quantity_sold]) VALUES (20, N'Mango Sticky Rice', N'Cook glutinous rice until tender. In a saucepan, heat coconut milk with sugar and salt until dissolved. Pour over the cooked rice and let absorb. Serve with sliced mango and drizzle with additional coconut milk.', CAST(7.49 AS Decimal(10, 2)), 3, N'https://www.simplyrecipes.com/thmb/Ifm5BWvRoCE0IoiyPbgknQ9DgZ0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Mango-Sticky-Rice-LEAD-03-5832b5091b1441238d9b750dc75e18da.jpg', 30, 15)



SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (1, N'nguyenvana', N'0000', N'nguyenvana@gmail.com', N'Nguyen Van A', N'0987654321', 1)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (2, N'nguyenvanb', N'0000', N'nguyenvanb@gmail.com', N'Nguyen Van B', N'0987654322', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (3, N'nguyenvanc', N'0000', N'nguyenvanc@gmail.com', N'Nguyen Van C', N'0987654323', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (4, N'nguyenvand', N'123456', N'nguyenvand@gmail.com', N'Nguyen Van D', N'0987654324', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (5, N'nguyenvane', N'123456', N'nguyenvane@gmail.com', N'Nguyen Van E', N'0987654325', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (6, N'nguyenvanf', N'123456', N'nguyenvanf@gmail.com', N'Nguyen Van F', N'0987654326', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (7, N'nguyenvang', N'123456', N'nguyenvang@gmail.com', N'Nguyen Van G', N'0987654327', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (8, N'nguyenvanh', N'123456', N'nguyenvanh@gmail.com', N'Nguyen Van H', N'0987654328', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (12, N'nguyenvant', N'123456', N'nguyenvant@gmail.com', N'Nguyen Van T', N'0987654342', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (13, N'nguyenvanu', N'123456', N'nguyenvanu@gmail.com', N'Nguyen Van U', N'0987654343', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (16, N'nguyenvanx', N'123456', N'nguyenvanx@gmail.com', N'Nguyen Van X', N'0987654346', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (17, N'nguyenvany', N'123456', N'nguyenvany@gmail.com', N'Nguyen Van Y', N'0987654347', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (18, N'nguyenvanz', N'123456', N'nguyenvanz@gmail.com', N'Nguyen Van Z', N'0987654348', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (22, N'MingQuang', N'0000', N'minhnqhe176167@fpt.edu.vn', N'Nguyen Quang Minh', N'0943081570', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (24, N'min', N'0000', N'minhnqhe176167@fpt.edu.vn', N'Nguyen Quang Minh', N'0943081570', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (27, N'linh', N'0000', N'linhntdHE172208@fpt.edu.vn', N'Nguyen Thi Dieu Linh', N'0378468362', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (28, N'Mings', N'0000', N'minhnqhe176167@fpt.edu.vn', N'Nguyen Quang Minh', N'0943081570', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (29, N'nguyenvani', N'123456', N'nguyenvani@gmail.com', N'Nguyen Van I', N'0987654329', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (30, N'nguyenvanj', N'123456', N'nguyenvanj@gmail.com', N'Nguyen Van J', N'0987654330', 0)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [full_name], [phone_number], [isAdmin]) VALUES (31, N'nguyenvanw', N'123456', N'nguyenvanw@gmail.com', N'Nguyen Van W', N'0987654345', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([orderID])
REFERENCES [dbo].[Orders] ([orderID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
USE [master]
GO
ALTER DATABASE [PRJ301_SU24_PlanMenu] SET  READ_WRITE 
GO
