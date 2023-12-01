import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class KKHomeTicketWidget extends StatelessWidget {
  const KKHomeTicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("KK游戏", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 13),),
                Text("KK推荐", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
              ],
            ),
            Row(
              children: [
                Text("查看全部", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),),
                SizedBox(height: 5,),
                Icon(Icons.chevron_right_outlined, size: 24, color: Color(0xFFB2B3BD),)
              ],
            )
          ],
        ),
        const SizedBox(height: 15,),
        SizedBox(
          height: 510,
          width: double.infinity,
          child: Swiper(
            autoplayDisableOnInteraction:false,
            itemCount: 5, itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 64,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/home_xianggangliuhecai.png",), fit: BoxFit.cover),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/home_liuhecai_icon.png", width: 44, height: 44,),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("香港六合彩", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),),
                              SizedBox(height: 5,),
                              Text("第2023 09999期", style: TextStyle(color: Colors.white, fontSize: 11),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                color: const Color(0xFFFF563F),
                                child: const Text("封盘中", style: TextStyle(color: Colors.white, fontSize: 11),),
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  Image.asset("assets/images/home_ticket_hit_icon.png", width: 10.5, height: 12,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const SizedBox(width: 2,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const Text(":", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const SizedBox(width: 2,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const Text(":", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const SizedBox(width: 2,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),


                                ],
                              )
                            ],
                          ),
                          GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.36), )
                                ),
                                width: 48,
                                height: 46,
                                child: const Center(
                                  child: Text("进入\n游戏", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 67,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2E374E),
                          ),
                          child: Center(
                            child: Text("红 : 1.98", style: TextStyle(color: Colors.white, fontSize: 12),),

                          ),
                        ),
                        const SizedBox(width: 25,),
                        Container(
                          width: 67,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2E374E),
                          ),
                          child: Center(
                            child: Text("红 : 1.98", style: TextStyle(color: Colors.white, fontSize: 12),),

                          ),
                        ),
                        const SizedBox(width: 25,),
                        Container(
                          width: 67,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2E374E),
                          ),
                          child: Center(
                            child: Text("红 : 1.98", style: TextStyle(color: Colors.white, fontSize: 12),),

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 101,
                          height: 31,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.5),
                            color: const Color(0xFF4338C9),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 30,
                                child: TextButton(
                                  style:  const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                                  onPressed: (){

                                  },
                                  child: Image.asset("assets/images/home_sub_icon.png", width: 12, height: 2.5,),
                                ),

                              ),
                              Container(
                                width: 35,
                                height: 22,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF30298B),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: const Color(0xFF9FC1EA))
                                ),
                                child: const TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                  cursorColor: Colors.white,
                                ),

                              ),
                              SizedBox(
                                width: 30,
                                height: 31,
                                child: TextButton(
                                  style:  const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero), alignment: Alignment.center),
                                  onPressed: (){

                                  },
                                  child: Image.asset("assets/images/home_add_icon.png", width: 12.5, height: 15,),
                                ),

                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25,),
                        Container(
                          width: 90,
                          height: 31,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.5),
                              gradient: const LinearGradient(
                                  colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]
                              )
                          ),
                          child: TextButton(
                            onPressed: (){

                            }, style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                            child: const Text("快捷投注", style: TextStyle(color: Colors.white, fontSize: 14),),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,)
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 64,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/home_xianggangliuhecai.png",), fit: BoxFit.cover),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/home_liuhecai_icon.png", width: 44, height: 44,),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("香港六合彩", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),),
                              SizedBox(height: 5,),
                              Text("第2023 09999期", style: TextStyle(color: Colors.white, fontSize: 11),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                color: const Color(0xFFFF563F),
                                child: const Text("封盘中", style: TextStyle(color: Colors.white, fontSize: 11),),
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  Image.asset("assets/images/home_ticket_hit_icon.png", width: 10.5, height: 12,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const SizedBox(width: 2,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const Text(":", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const SizedBox(width: 2,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const Text(":", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),
                                  const SizedBox(width: 2,),
                                  Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
                                        )
                                    ),
                                    child: const Text("1", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                                  ),


                                ],
                              )
                            ],
                          ),
                          GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.36), )
                                ),
                                width: 48,
                                height: 46,
                                child: const Center(
                                  child: Text("进入\n游戏", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          ),
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                              ),
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,

                            ),
                            child: const Center(
                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 67,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2E374E),
                          ),
                          child: Center(
                            child: Text("红 : 1.98", style: TextStyle(color: Colors.white, fontSize: 12),),

                          ),
                        ),
                        const SizedBox(width: 25,),
                        Container(
                          width: 67,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2E374E),
                          ),
                          child: Center(
                            child: Text("红 : 1.98", style: TextStyle(color: Colors.white, fontSize: 12),),

                          ),
                        ),
                        const SizedBox(width: 25,),
                        Container(
                          width: 67,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2E374E),
                          ),
                          child: Center(
                            child: Text("红 : 1.98", style: TextStyle(color: Colors.white, fontSize: 12),),

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 101,
                          height: 31,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.5),
                            color: const Color(0xFF4338C9),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 30,
                                child: TextButton(
                                  style:  const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                                  onPressed: (){

                                  },
                                  child: Image.asset("assets/images/home_sub_icon.png", width: 12, height: 2.5,),
                                ),

                              ),
                              Container(
                                width: 35,
                                height: 22,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF30298B),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: const Color(0xFF9FC1EA))
                                ),
                                child: const TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                  cursorColor: Colors.white,
                                ),

                              ),
                              SizedBox(
                                width: 30,
                                height: 31,
                                child: TextButton(
                                  style:  const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero), alignment: Alignment.center),
                                  onPressed: (){

                                  },
                                  child: Image.asset("assets/images/home_add_icon.png", width: 12.5, height: 15,),
                                ),

                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25,),
                        Container(
                          width: 90,
                          height: 31,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.5),
                              gradient: const LinearGradient(
                                  colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]
                              )
                          ),
                          child: TextButton(
                            onPressed: (){

                            }, style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                            child: const Text("快捷投注", style: TextStyle(color: Colors.white, fontSize: 14),),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,)
                  ],
                ),
              ],
            );
          },
            pagination: const SwiperPagination(), ),
        )


      ],
    );
  }

}

